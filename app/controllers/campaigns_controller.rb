class CampaignsController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!
  before_action :set_campaign, only: [:edit, :update, :destroy]
  respond_to :json
=======
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

  # GET /campaigns
  # GET /campaigns.json
  def index
<<<<<<< HEAD
    @campaigns = Campaign.where(user_id: params[:user_id])
    # @new_campaign = Campaign.new
    render json: @campaigns
=======
    @campaigns = Campaign.where(user_id: current_user)
    @new_campaign = Campaign.new
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
<<<<<<< HEAD

  def show
    @campaign = Campaign.where(id: params[:id]).as_json(
      :include => {
        :saved_jobs => {
          :include => {
            :job => {
              :include => {
                :writer => {
                  only: [:id, :f_name, :l_name]
                },
                :outlet => {
                  only: :name
                }
              }
            }
          }
        }
      }
    )
    render json:  @campaign
=======
  def show
    @campaigns = Campaign.where(user_id: current_user)
    saved = SavedJob.where(campaign_id: @campaign.id)
    outlet_arr = []
    job_arr = []
    saved.each do |s|
      outlet_arr.push(s.job.outlet_id) unless outlet_arr.include?(s.job.outlet_id)
      job_arr.push(s.job.id)
    end
    @outlets = Outlet.find(outlet_arr)
    @jobs = Job.find(job_arr)
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  end


  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.save
    respond_to do |format|
      if @campaign.save
<<<<<<< HEAD
        # format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
=======
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
        format.json { render json: @campaign}
      end
    end
  end

<<<<<<< HEAD

  def copy
    id = params[:copy_campaign][:campaign_id]
    name = params[:copy_campaign][:new_campaign_name]
    @current_campaign = Campaign.includes(:saved_jobs).find_by(id: id)
    if name.empty?
      name = @current_campaign.name
    end
    @new_campaign = Campaign.new(user_id: @current_campaign.user_id, name: "#{name}", artist:@current_campaign.artist, promotion: @current_campaign.promotion, notes:@current_campaign.notes)
    @new_campaign.save
    sj_arr = []
    @current_campaign.saved_jobs.each do |sj|
        sj_arr.push(sj.job_id)
      end
    sj_arr.each do |sj|
      nsj = SavedJob.new(campaign_id: @new_campaign.id, job_id: sj)
      nsj.save
    end
    render json: @new_campaign
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    # respond_to do |format|
      if @campaign.update(campaign_params)
        render json: {campaign: @campaign, notice: 'Campaign was successfully updated.'}
        # format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        # format.json { render :show, status: :ok, location: @campaign }
      else
        render json: { errors:@campaign.errors, status: :unprocessable_entity }
        # format.html { render :edit }
        # format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    # end
  end


  def update_note
    id = params[:id]
    notes = params[:campaign][:notes]
    @campaign = Campaign.find(id)
    @campaign.update(notes: notes)
    render json: @campaign
=======
  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
<<<<<<< HEAD
    # respond_to do |format|
      # format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      render json: { notice: 'Campaign was successfully destroyed' }
    # end
=======
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  end

  # POST /campaigns/flag
  def flag
    FlagMailer.flag_email(params["flag"]).deliver
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
<<<<<<< HEAD
      params.require(:campaign).permit(:user_id, :name, :artist, :promotion)
=======
      params.require(:campaign).permit(:user_id, :name)
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
    end
end
