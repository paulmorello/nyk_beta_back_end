class SavedJobsController < ApplicationController
  before_action :set_saved_job, only: [:update]
  respond_to :html, :xml, :json

  # POST /saved_jobs
  # POST /saved_jobs.json
  def create
    campaign_id = params[:saved_job][:campaign_id]
    job_ids = params[:saved_job][:job_ids]
    job_ids.each do |id|
      unless SavedJob.where(campaign_id: campaign_id, job_id: id).present?
        SavedJob.create(campaign_id: campaign_id, job_id: id, response: "none")
      end
    end
  end

  # PATCH/PUT /saved_jobs/1
  # PATCH/PUT /saved_jobs/1.json
  def update
    response = params[:saved_job][:response]
    @saved_job.update(response: response, response_updated_at: Time.now)
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
    redirect_to "/campaigns/#{@campaign_id}"
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
