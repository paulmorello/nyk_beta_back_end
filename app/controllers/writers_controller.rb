class WritersController < ApplicationController
  before_action :set_writer, only: [:show, :edit, :update, :destroy]
  before_action :set_job, only: [:delete_job]
  before_action :is_admin?, only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /writers
  # GET /writers.json
  def index  # This is being used for admins to see writers assigned to them
    @writers = Writer.where(inactive: false)
    @outlets = Outlet.where(inactive: false)
  end

  # GET /writers/1
  # GET /writers/1.json
  def show
  end

  # GET /writers/new
  def new
    @writer = Writer.new
  end

  # GET /writers/1/edit
  def edit
  end

  # POST /writers
  # POST /writers.json
  def create
    @writer = Writer.new(writer_params)

    respond_to do |format|
      if @writer.save
        format.html { redirect_to outlets_path, notice: 'Writer was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writers/1
  # PATCH/PUT /writers/1.json
  def update
    respond_to do |format|
      if @writer.update(writer_params)
        format.html { redirect_to outlets_path, notice: 'Writer was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writers/1
  # DELETE /writers/1.json
  def destroy
    # @writer.destroy
    @writer.update(inactive: true)
    respond_to do |format|
      format.html { redirect_to outlets_url, notice: 'Writer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /writers/delete_job/1
  def delete_job
    writer_id = @job.writer_id
    @job.destroy
    respond_to do |format|
      format.html { redirect_to "/writers/#{writer_id}/edit", notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writer
      @writer = Writer.find(params[:id])
    end

    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def writer_params
      params.require(:writer).permit(:f_name,:l_name, :email_personal, :city, :state, :country_id,:twitter, :linkedin, :freelance, :notes, :user_id, genre_tags_attributes: [:id, :genre_id, :_destroy], jobs_attributes: [:id, :outlet_id, :email_work, :position, :outlet_profile, :key_contact, :_destroy, presstype_tags_attributes: [:id, :presstype_id, :_destroy]])
    end
end
