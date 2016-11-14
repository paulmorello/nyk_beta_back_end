
class OutletsController < ApplicationController
  before_action :set_outlet, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /outlets
  # GET /outlets.json
  def index  # Essentially the main page of the application proper. This is the discover page.
    @outlets = Outlet.all.order(:name).paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.js { render "layouts/morecontacts" }
    end
  end

  # GET /outlets/1
  # GET /outlets/1.json
  def show
  end

  # GET /outlets/new
  def new
    @outlet = Outlet.new
  end


  def search
    # POST /outlets/search
    if request.post?
      if params[:q].present? != true || params[:q] == "Search"
        redirect_to outlets_path
        return
      end
      redirect_to '/outlets/search/'+params[:q]
    # GET /outlets/search/:q
    elsif request.get?
      @outlets = Outlet.where("name ILIKE ?", "%#{params[:q]}%").distinct.order(:name)
      writers = Writer.where("lower(f_name || ' ' || l_name) ILIKE ?", "%#{params[:q]}%").distinct.order(:l_name)
      # Everything below just for making sure not to double writers or outlets after search
      @jobs = []
      outlet_ids = []
      if @outlets.empty? == false
        writers.each do |writer|
          writer.jobs.each do |job|
            if @outlets.any? {|o| o[:id] != job.outlet.id}
              @jobs.push(job)
              outlet_ids.push(job.outlet_id)
            end
          end
        end
      elsif @outlets.empty? == true
        writers.each do |writer|
          writer.jobs.each do |job|
            @jobs.push(job)
            outlet_ids.push(job.outlet_id)
          end
        end
      end
      @outlet_ids = outlet_ids.uniq
    end
  end

  def filter
    filters = params[:filter_params]
    if filters["genre_id"]
      filters["genre_id"].delete("")
    end
    if filters["presstype_id"]
      filters["presstype_id"].delete("")
    end
    @filters = filters
    @outlets = Outlet.all.order(:name)
    if filters["hype_m"] === "1"
      @outlets = @outlets.where(hype_m: true)
    end
    if filters["submithub"] === "1"
      @outlets = @outlets.where(submithub: true)
    end
    if filters["country_id"] != ""
      o_arr = []
      @outlets.each do |outlet|
        if outlet.country_id.to_s == filters["country_id"] || outlet.writers.where(country_id: filters["country_id"]).present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["state"] != ""
      o_arr = []
      @outlets.each do |outlet|
        if outlet.state.to_s.downcase.include?(filters["state"].downcase) || outlet.writers.where("state ILIKE ?", "%#{filters["state"]}%").present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["city"] != ""
      o_arr = []
      @outlets.each do |outlet|
        if outlet.city.to_s.downcase.include?(filters["city"].downcase) || outlet.writers.where("city ILIKE ?", "%#{filters["city"]}%").present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["presstype_id"].present?
      @outlets = @outlets.joins(jobs: :presstype_tags).where(presstype_tags: {presstype_id: filters["presstype_id"]}).distinct
    end
    if filters["genre_id"].present?
      g_ids_plus_all = filters["genre_id"]
      g_ids_plus_all.push("1") unless g_ids_plus_all.include?("1")
      @outlets = @outlets.joins(writers: :genre_tags).where(genre_tags: {genre_id: g_ids_plus_all}).distinct
    end
    @outlets = @outlets.paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.js { render "layouts/morefilteredcontacts" }
    end
  end

  # GET /outlets/1/edit
  def edit
  end

  # POST /outlets
  # POST /outlets.json
  def create
    @outlet = Outlet.new(outlet_params)
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to @outlet, notice: 'Outlet was successfully created.' }
        format.json { render :show, status: :created, location: @outlet }
      else
        format.html { render :new }
        format.json { render json: @outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outlets/1
  # PATCH/PUT /outlets/1.json
  def update

    respond_to do |format|
      # twitter follower test
      if @outlet.twitter.present?
        credentials = Base64.encode64("#{TWITTER_ID}:#{TWITTER_SECRET}").gsub("\n", '')
        url = "https://api.twitter.com/oauth2/token"
        body = "grant_type=client_credentials"
        headers = {
          "Authorization" => "Basic #{credentials}",
          "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        }
        r = HTTParty.post(url, body: body, headers: headers)
        bearer_token = JSON.parse(r.body)['access_token']

        api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
        url = "https://api.twitter.com/1.1/users/show.json?screen_name=#{@outlet.twitter}"
        response = HTTParty.get(url, headers: api_auth_header).body
        parsed_response = JSON.parse(response)
        twitter_followers = parsed_response["followers_count"].to_s

        if twitter_followers.present?
          if twitter_followers.length > 3
            twitter_followers = twitter_followers.chop.chop.chop+"k"
          end
          @outlet.update(twitter_followers: twitter_followers)
        end
      end

      # facebook follower test
      if @outlet.facebook.present?
        url = "https://graph.facebook.com/#{@outlet.facebook}?fields=fan_count&access_token=#{FACEBOOK_ID}|#{FACEBOOK_SECRET}"
        facebook_response = HTTParty.get url
        parsed_facebook_response = JSON.parse(facebook_response)
        facebook_followers = parsed_facebook_response["fan_count"].to_s
        if facebook_followers.present?
          if facebook_followers.length > 3
            facebook_followers = facebook_followers.chop.chop.chop+"k"
          end
          @outlet.update(facebook_likes: facebook_followers)
        end
      end

      # insta follower test
      if @outlet.instagram.present?
        url = "https://www.instagram.com/web/search/topsearch/?query=#{@outlet.name}"
        insta_response = HTTParty.get url
        insta_followers = insta_response["users"].first["user"]["byline"].chomp(" followers")
        if insta_followers.present?
          @outlet.update(instagram_followers: insta_followers)
        end
      end

      if @outlet.update(outlet_params)
        format.html { redirect_to @outlet, notice: 'Outlet was successfully updated.' }
        format.json { render :show, status: :ok, location: @outlet }
      else
        format.html { render :edit }
        format.json { render json: @outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outlets/1
  # DELETE /outlets/1.json
  def destroy
    @outlet.destroy
    respond_to do |format|
      format.html { redirect_to outlets_url, notice: 'Outlet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlet_params
      params.require(:outlet).permit(:name,:website,:email,:staff_list, :description, :city,:state,:country_id,:twitter,:facebook,:instagram,:linkedin,:hype_m,:submithub, :notes, :user_id)
    end
end
