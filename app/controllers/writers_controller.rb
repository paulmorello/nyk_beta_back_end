class WritersController < ApplicationController
  before_action :set_writer, only: [:show, :edit, :update, :destroy]
  before_action :set_custom_errors

  # GET /writers
  # GET /writers.json
  def index
    @writers = Writer.all
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
    outlet = Outlet.find_by(name: params["outlet"])
    @writer.outlets.push(outlet)
    respond_to do |format|
      if @writer.save
        format.html { redirect_to @writer, notice: 'Writer was successfully created.' }
        format.json { render :show, status: :created, location: @writer }
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
      @writer.assign_attributes(writer_params)
      valid_writer = @writer.valid?
      if valid_writer && validate_outlet(params["outlet"])
        @writer.update(writer_params)
        if params["outlet"] != "" # accounting for blank entry but writer has at least on outlet. Valid, but we don't want to save blank entry
          @writer.outlets.push(Outlet.find_by(name: params["outlet"]))
        end
        format.html { redirect_to @writer, notice: 'Writer was successfully updated.' }
        format.json { render :show, status: :ok, location: @writer }
      else
        format.html { render :edit }
        # custom errors not being passed
        format.json { render json: @writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writers/1
  # DELETE /writers/1.json
  def destroy
    @writer.destroy
    respond_to do |format|
      format.html { redirect_to writers_url, notice: 'Writer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writer
      @writer = Writer.find(params[:id])
    end

    def set_custom_errors
      @custom_errors = []
    end

    def validate_outlet(entry)
      is_valid = false
      outlet = Outlet.find_by(name: entry)
      join_does_not_already_exist = !(@writer.outlets.exists?(name: entry))
      if outlet && join_does_not_already_exist
        is_valid = true
        return is_valid
      elsif entry == "" && (@writer.outlets.count >= 1)
        is_valid = true
        return is_valid # but we don't want to save a blank string so must account where saving
      elsif entry == "" && (@writer.outlets.count < 1)
        @custom_errors += ["Must enter Outlet"]
        return is_valid
      elsif !join_does_not_already_exist
        @custom_errors += ["Writer is already connected to that Outlet"]
        return is_valid
      elsif !(outlet)
        @custom_errors += ["Outlet does not exist. Check to see if created, and that Outlet is typed exactly."]
        return is_valid
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def writer_params
      params.require(:writer).permit(:f_name,:l_name, :position, :outlet, :outlet_profile, :email_work, :email_personal, :city, :state, :country_id,:twitter,:facebook,:instagram,:linkedin, :key_contact, :freelance)
    end
end
