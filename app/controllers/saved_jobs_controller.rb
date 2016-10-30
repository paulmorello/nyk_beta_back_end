class SavedJobsController < ApplicationController
  before_action :set_saved_job, only: [:update, :destroy]
  respond_to :html, :xml, :json

  # POST /saved_jobs
  # POST /saved_jobs.json
  def create
    campaign_id = params[:saved_job][:campaign_id]
    job_ids = params[:saved_job][:job_ids]

    job_ids.each do |id|
      unless SavedJob.where(campaign_id: campaign_id, job_id: id).present?
        SavedJob.create(campaign_id: campaign_id, job_id: id)
      end
    end
  end

  # PATCH/PUT /saved_jobs/1
  # PATCH/PUT /saved_jobs/1.json
  def update
    # respond_to do |format|
    #   if @campaign.update(campaign_params)
    #     format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @campaign }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @campaign.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /saved_jobs/1
  # DELETE /saved_jobs/1.json
  def destroy
    # @campaign.destroy
    # respond_to do |format|
    #   format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_saved_job
    @saved_job = SavedJob.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def saved_job_params
    params.require(:saved_job).permit(:campaign_id, :job_ids => [])
  end
end
