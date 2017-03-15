class WritersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_writer, only: [:edit, :update, :destroy ]
  before_action :set_job, only: [:delete_job]
  # before_action :is_admin?, only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /writers
  # GET /writers.json
  def index  # This is being used for admins to see writers assigned to them
    @writers = Writer.where(inactive: false)
    @outlets = Outlet.where(inactive: false)
  end

  # GET /writers/1
  # GET /writers/1.json
  def show
    @writer = Writer.where(inactive:false).where(id: params[:id]).as_json(
      :include => {
        :jobs => {
          :include =>
            { :presstype_tags => {
              only: [:id, :job_id],
              :include => {
                :presstype => {
                  only: [:id, :name]
                }
              }
            },
              :outlet => {
                except: [:updated_at]
              }
              }
        },
        :genre_tags => {
          only: [:id, :writer_id, :genre_id],
          :include => {
            :genre => {
              only: [:id, :name]
            }
          }
        }
      }
    )

    render json: @writer
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
    @writer = Writer.create(writer_params)

    # respond_to do |format|
      if @writer.save
        # format.html { redirect_to outlets_path, notice: 'Writer was successfully created.' }
        render json: { notice: 'Writer was successfully created.', writer: @writer.as_json(:include  => {:jobs => {only: [:outlet_id]}})}
      else
        # format.html { render :new }
        render json: { errors: @writer.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /writers/1
  # PATCH/PUT /writers/1.json
  def update
      jobs = params[:writer][:jobs_attributes]
      genre_tags = params[:writer][:genre_tags_attributes]
    # respond_to do |format|
      # twitter follower test
      if @writer.twitter.present?
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
        url = "https://api.twitter.com/1.1/users/show.json?screen_name=#{@writer.twitter}"
        response = HTTParty.get(url, headers: api_auth_header).body
        parsed_response = JSON.parse(response)
        twitter_followers = parsed_response["followers_count"].to_s

        if twitter_followers.present?
          if twitter_followers.length > 3
            twitter_followers = twitter_followers.chop.chop.chop+"k"
          end
          @writer.update(twitter_followers: twitter_followers)
        end
      end

      if @writer.update(writer_params)
        # format.html { redirect_to edit_outlet_path(@writer), notice: 'Writer was successfully updated.' }
        render json: {writer: @writer, notice: 'Writer was successfully updated.'}
      else
        render json: {errors:Rails.logger.info(@writer.errors.inspect), status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /writers/1
  # DELETE /writers/1.json
  def destroy
    # @writer.destroy
    @writer.update(inactive: true)
    render json: {
      notice: 'Writer was successfully destroyed.',
      error: Rails.logger.info(@writer.errors.inspect)}
    # respond_to do |format|
    #   format.html { redirect_to outlets_url, notice: 'Writer was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  # DELETE /writers/delete_job/1
  def delete_job
    # writer_id = @job.writer_id
    @job.destroy
    render json: {notice: 'Job was successfully destroyed.'}
    # respond_to do |format|
    #   format.html { redirect_to "/writers/#{writer_id}/edit", notice: 'Job was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def delete_genre_tag
    gtag = GenreTag.find(params[:id])
    if gtag.destroy
      render json: {notice: 'Genre Tag successfully destroyed'}
    else
      render json: {error: Rails.logger.info(gtag.errors.inspect), status: :unprocessable_entity}
    end
  end

  def delete_presstype_tag
    ptag = PresstypeTag.find(params[:id])
    if ptag.destroy
      render json: {notice: 'Presstype Tag successfully destroyed'}
    else
      render json: {error: Rails.logger.info(ptag.errors.inspect), status: :unprocessable_entity}
    end
  end

  def flag
    flag = params[:flag]
    FlagMailer.flag_email(flag).deliver
    render json: {notice: 'Writer was successfully flagged'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writer
      @writer = Writer.where(inactive:false).find(params[:id])
    end

    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def writer_params
      params.require(:writer).permit(:f_name,:l_name, :email_personal, :city, :state, :country_id,:twitter, :linkedin, :freelance, :notes, :user_id, jobs_attributes: [:id, :outlet_id, :email_work, :secondary_email_work, :notes, :position, :outlet_profile, :key_contact, :_destroy, presstype_tags_attributes: [:id, :presstype_id, :job_id, :_destroy]], genre_tags_attributes: [:id, :genre_id, :writer_id, :_destroy])
    end

    # def writer_update_params
    #   params.require(:writer).permit(:f_name,:l_name, :email_personal, :city, :state, :country_id,:twitter, :linkedin, :freelance, :notes, :user_id)
    # end
end

# }
