class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]


  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.where(user_id: current_user)
    @new_campaign = Campaign.new
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
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
  end


  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { redirect_to campaigns_path }
      end
    end
  end

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
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:user_id, :name)
    end
end
