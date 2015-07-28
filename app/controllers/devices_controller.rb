class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to venues_url, notice: 'device was successfully created.' }
        # format.html { redirect_to venue_device_path(@device.venue, @device), notice: 'device was successfully created.' }
        format.json { render :show, status: :created, location: venue_device_path(@device.venue, @device) }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    @device = Device.find(params[:id])
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to venues_url, notice: 'device was successfully updated.' }
        # format.html { redirect_to venue_device_path(@device.venue, @device), notice: 'device was successfully updated.' }
        format.json { render :show, status: :ok, location: venues_url }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    @venue = @device.venue
    @device.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'device was successfully destroyed.' }
      # format.html { redirect_to @venue, notice: 'device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :venue_id, :enter, :leave)
    end
end
