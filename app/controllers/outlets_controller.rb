class OutletsController < ApplicationController
  before_action :set_outlet, only: [:show, :edit, :update, :destroy]
  before_action :set_countries

  # GET /outlets
  # GET /outlets.json
  def index  # Essentially the main page of the application proper. This is the discover page.
    @outlets = Outlet.all
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
      @outlets  = Outlet.where("name ILIKE ?", "%#{params[:q]}%")
      writers = Writer.where("f_name ILIKE ? OR l_name ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
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
    filters["genre_id"].delete("")
    filters["presstype_id"].delete("")
    @filters = filters
    @outlets = Outlet.all
    if filters["hype_m"] === "1"
      @outlets = @outlets.where(hype_m: true)
    end
    if filters["submithub"] === "1"
      @outlets = @outlets.where(submithub: true)
    end
    if filters["country_id"] != ""
      @outlets = @outlets.where(country_id: filters["country_id"])
    end
    if filters["presstype_id"].present?
      @outlets = @outlets.joins(jobs: :presstype_tags).where(presstype_tags: {presstype_id: filters["presstype_id"]}).distinct
    end
    if filters["genre_id"].present?
      g_ids_plus_all = filters["genre_id"]
      g_ids_plus_all.push("1") unless g_ids_plus_all.include?("1")
      @outlets = @outlets.joins(writers: :genre_tags).where(genre_tags: {genre_id: g_ids_plus_all}).distinct
    end
    # Add filter to not include outlets where there are no freelancers if selected
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
      params.require(:outlet).permit(:name,:website,:email,:staff_list, :description, :city,:state,:country_id,:twitter,:facebook,:instagram,:linkedin,:hype_m,:submithub, :notes)
    end
end
