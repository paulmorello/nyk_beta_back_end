
class OutletsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  include OutletsHelper
  before_action :set_outlet, only: [:show, :edit, :update, :destroy]
  # before_action :is_admin?, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :authenticate_user!

  # GET /outlets
  # GET /outlets.json
  def index  # Essentially the main page of the application proper. This is the discover page.
    #@outlets = Outlet.where(inactive: false).order(:name).paginate(page: params[:page], per_page: 20)
    if current_user.trial == true
      fetch_trial_outlets
    else
      fetch_outlets
    end
    render json: @outlets
  end

  # GET /outlets/1
  # GET /outlets/1.json
  def show
    fetch_outlet
    render json: @exported_outlet
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
      puts "valid get request"
      @outlets = Outlet.where(inactive: false).where("name ILIKE ?", "%#{params[:q]}%").distinct.order(:name)
      writers = Writer.where(inactive: false).where("lower(f_name || ' ' || l_name) ILIKE ?", "%#{params[:q]}%").distinct.order(:f_name)
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
      @outlet_ids = outlet_ids
      @outlets_results = @outlets.as_json
      if @outlet_ids.empty? == false
        @outlet_ids.each do |o|
          outlet_by_writer = Outlet.includes(:jobs, :writers).where(id: o)
          @exported_outlet = reshape_data(outlet_by_writer)
          @outlets_results.push(@exported_outlet)
        end
      end
      render json: @outlets_results
    end
  end

  def filter
    filters = params["filters"]
    if filters["genre_id"]
      filters["genre_id"].delete("")
    end
    if filters["presstype_id"]
      filters["presstype_id"].delete("")
    end
    @outlets = Outlet.where(inactive: false).order(:name)
    if filters["hype_m"] == true
      @outlets = @outlets.where(hype_m: true)
    end
    if filters["submithub"] == true
      @outlets = @outlets.where(submithub: true)
    end
    if filters["country_id"].nil? == false
      filters["country_id"] = Country.find_by(name: filters["country_id"]).id
      o_arr = []
      @outlets.each do |outlet|
        if outlet.country_id.to_s == filters["country_id"] || outlet.writers.where(country_id: filters["country_id"]).present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["state"].nil? == false
      o_arr = []
      @outlets.each do |outlet|
        if outlet.state.to_s.downcase.include?(filters["state"].downcase) || outlet.writers.where("state ILIKE ?", "%#{filters["state"]}%").present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["city"].nil? == false
      o_arr = []
      @outlets.each do |outlet|
        if outlet.city.to_s.downcase.include?(filters["city"].downcase) || outlet.writers.where("city ILIKE ?", "%#{filters["city"]}%").present?
          o_arr.push(outlet.id)
        end
      end
      @outlets = @outlets.where(id: o_arr)
    end
    if filters["presstype_id"].present?
      filters["presstype_id"] = Presstype.find_by(name: filters["presstype_id"]).id
      @outlets = @outlets.joins(jobs: :presstype_tags).where(presstype_tags: {presstype_id: filters["presstype_id"]}).distinct
    end
    if filters["genre_id"].present?
      filters["genre_id"] = Genre.find_by(name: filters["genre_id"]).id
      g_ids_plus_all = [filters["genre_id"]]
      g_ids_plus_all.push("19") unless g_ids_plus_all.include?("19")
      @outlets = @outlets.joins(writers: :genre_tags).where(genre_tags: {genre_id: g_ids_plus_all}).distinct
    end
    render json: @outlets
  end

  # GET /outlets/1/edit
  def edit
  end

  # POST /outlets
  # POST /outlets.json
  def create
    @outlet = Outlet.new(outlet_params)
    # respond_to do |format|
      if @outlet.save
        # format.html { redirect_to outlets_path, notice: 'Outlet was successfully created.' }
        render json: {status:"Successfully added!", outlet: @outlet}
      else
        # format.html { render :new }
        # format.json { render json: @outlet.errors, status: :unprocessable_entity }
        render json: {status:"Couldn't add outlet", outlet: @outlet}
      end
    # end
  end

  # PATCH/PUT /outlets/1
  # PATCH/PUT /outlets/1.json
  def update
    # @outlet = Outlet.find(id: params[:outlet][:id])

    # respond_to do |format|
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
        facebook_response = HTTParty.get(url)
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
      # if @outlet.instagram.present?
      #   url = "https://www.instagram.com/web/search/topsearch/?query=#{@outlet.name}"
      #   insta_response = HTTParty.get url
      #   insta_followers = insta_response["users"].first["user"]["byline"].chomp(" followers")
      #   if insta_followers.present?
      #     @outlet.update(instagram_followers: insta_followers)
      #   end
      # end



      if @outlet.update(outlet_params)

        # format.html { redirect_to edit_outlet_path(@outlet), notice: 'Outlet was successfully updated.' }
        render json: {status:"Update successful", outlet: @outlet}
      else
        # format.html { render :edit }
        # format.json { render json: @outlet.errors, status: :unprocessable_entity }
        render json: {status:"Update unsuccessful", outlet: @outlet, error: Rails.logger.info(@outlet.errors.inspect)}
      end
    # end
  end

  # DELETE /outlets/1
  # DELETE /outlets/1.json
  def destroy
    # @outlet.destroy
    @outlet.update(inactive: true)
    # respond_to do |format|
      # format.html { redirect_to outlets_url, notice: 'Outlet was successfully destroyed.' }
      # format.json { head :no_content }
    # end
    render json: { notice: 'Outlet was successfully destroyed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlet_params
      params.require(:outlet).permit(
      :id, :name,:website,:email,
      :city,:state,:country_id,
      :twitter, :facebook, :instagram,
      :linkedin, :twitter_followers, :facebook_likes, :instagram_followers,
      :hype_m, :submithub, :flagged, :inactive, :notes,
      :description, :staff_list, :user_id,
      :second_email, :third_email
      )
    end

    def fetch_outlets
      outlets = $redis.get('outlets')
      if outlets.nil?
        puts 'nil'
        @outlets = Outlet.where(inactive: false).order(:name).as_json(
          :include => {
            :jobs => {
              :include =>
                [:presstypes,
                :writer => {
                  only: [:id, :f_name, :l_name],
                  :include => {
                    :genres => {
                      only: [:id, :name]
                    }
                  }
                }]
            },
            :country => {
              only: [:id, :name]
            }
          }
        )
        $redis.set('outlets', JSON.generate(@outlets.as_json))
        $redis.expire('outlets', 5.seconds.to_i)
      else
        puts 'redis'
        @outlets = JSON.parse(outlets)
      end
    end

    def fetch_trial_outlets
      @outlets = Outlet.where(name: '3musicguys').as_json(
        :include => {
          :jobs => {
            :include =>
              [:presstypes,
              :writer => {
                only: [:id, :f_name, :l_name],
                :include => {
                  :genres => {
                    only: [:id, :name]
                  }
                }
              }]
          },
          :country => {
            only: [:id, :name]
          }
        }
      )
      .or(Outlet.where(name: 'All The Greatest Music')
      .as_json(
        :include => {
          :jobs => {
            :include =>
              [:presstypes,
              :writer => {
                only: [:id, :f_name, :l_name],
                :include => {
                  :genres => {
                    only: [:id, :name]
                  }
                }
              }]
          },
          :country => {
            only: [:id, :name]
          }
        }
      )).or(Outlet.where(name: 'Anthesis Music Blog').as_json(
        :include => {
          :jobs => {
            :include =>
              [:presstypes,
              :writer => {
                only: [:id, :f_name, :l_name],
                :include => {
                  :genres => {
                    only: [:id, :name]
                  }
                }
              }]
          },
          :country => {
            only: [:id, :name]
          }
        }
      ))
    end


    def fetch_outlet
      puts "params: #{params[:id]}"
      id = params[:id]
      outlet_redis = "@exported_outlet_#{id}"
      outlet = $redis.get(outlet_redis)
      if outlet.nil?
        puts 'nil'
        outlet = Outlet.where(inactive: false, id: id).includes(:jobs, :writers)
        # TODO: find a way to bundle genres with this. Maybe (:includes => :genre_tags) or somethign?
        @exported_outlet = reshape_data(outlet)
        $redis.set("@exported_outlet_#{id}", JSON.generate(@exported_outlet.as_json))
        $redis.expire("@exported_outlet_#{id}", 10.seconds.to_i)
      else
        puts 'redis'
        @exported_outlet = outlet
      end
    end

end
