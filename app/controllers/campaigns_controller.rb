class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.where(user_id: params[:user_id])
    # @new_campaign = Campaign.new
    render json: @campaigns
  end

  # GET /campaigns/1
  # GET /campaigns/1.json

  ReStrucCamp = Struct.new(
    :id,
    :name,
    :user_id,
    :created_at,
    :updated_at,
    :notes,
    :artist,
    :promotion
    )

  def show
    campaign = Campaign.find_by(id: params[:id])
    saved = SavedJob.where(campaign_id: campaign.id).order(created_at: :desc)
    outlet_arr = []
    job_arr = []
    saved.each do |s|
      outlet_arr.push(s.job.outlet_id) unless outlet_arr.include?(s.job.outlet_id)
      job_arr.push(s.job.id)
    end
    @outlets = Outlet.find(outlet_arr)
    @jobs = []
    jobs = Job.find(job_arr)
    jobs.each do |j|
      @jobs.push({
        job: j,
        details: j.saved_jobs[0],
        writer: j.writer,
        outlet: j.outlet
        })
      end
    # TODO we need to have Outlets, Jobs, Writers, organized by Saved Jobs, which are owned by Campaigns

    deconstructed = ReStrucCamp.new(
      campaign.id,
      campaign.name,
      campaign.user_id,
      campaign.created_at,
      campaign.updated_at,
      campaign.notes,
      campaign.artist,
      campaign.promotion
      )
    @campaign = deconstructed.to_h
    @campaign[:saved_jobs] = @jobs
    @campaign[:saved_outlets] = @outlets
    render json:  @campaign
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
        # format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render json: @campaign}
      end
    end
  end


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


  def update_note
    id = params[:id]
    notes = params[:campaign][:notes]
    @campaign = Campaign.find(id)
    @campaign.update(notes: notes)
    render json: @campaign
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      # format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { render json: 'Campaign was successfully destroyed' }
    end
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
      params.require(:campaign).permit(:user_id, :name, :artist, :promotion)
    end
end
