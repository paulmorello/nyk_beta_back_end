class SavedJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_saved_job, only: [:show, :update]
  respond_to :html, :xml, :json

  # def show
  #   render json: @saved_job
  # end

  # POST /saved_jobs
  # POST /saved_jobs.json
  def create
    campaign_id = params[:saved_job][:campaign_id]
    job_ids = params[:saved_job][:job_ids].split(",")
    count = 0
    job_ids.each do |id|
      unless SavedJob.where(campaign_id: campaign_id, job_id: id).present?
        SavedJob.create(campaign_id: campaign_id, job_id: id, response: "")
        count += 1
      end
    end
    render json: {status: "Created #{count} jobs"}
  end

  # PATCH/PUT /saved_jobs/1
  # PATCH/PUT /saved_jobs/1.json
  def update
    response = params[:saved_job][:response]
    followed_up = params[:saved_job][:followed_up]
    response_updated_at = params[:saved_job][:response_updated_at]

    if response == "Yes"
      @saved_job.update(response: "Yes", response_updated_at: DateTime.now)
    elsif response == nil && followed_up == nil && response_updated_at == nil
      @saved_job.update(response: nil, response_updated_at: nil)
    end
    if followed_up == "Yes"
      @saved_job.update(followed_up: "Yes", response_updated_at: DateTime.now)
    elsif followed_up == nil && response == nil && response_updated_at == nil
      @saved_job.update(followed_up: nil, response_updated_at: nil)
    end
    #if response_updated_at != nil
    #  @saved_job.update(response_updated_at: response_updated_at)
    #elsif response_updated_at == nil && response == nil && response_updated_at == nil
    #  @saved_job.update(response_updated_at: nil)
    #end
    render json: @saved_job
  end

  # DELETE /saved_jobs
  def destroy
    @campaign_id = params[:saved_job][:campaign_id]
    job_ids = params[:saved_job][:job_ids]
    job_ids.each do |id|
      if SavedJob.where(campaign_id: @campaign_id, job_id: id).present?
        savedjob = SavedJob.where(campaign_id: @campaign_id, job_id: id).first
        SavedJob.destroy(savedjob.id)
      end
    end
    # redirect_to "/campaigns/#{@campaign_id}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_saved_job
    @saved_job = SavedJob.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def saved_job_params
    params.require(:saved_job).permit(:campaign_id, :response, :job_ids => [])
  end
end
