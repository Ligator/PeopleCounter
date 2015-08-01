class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :singlevenue]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all.order("counter DESC")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def allvenues
    @venues = Venue.all.order("counter DESC")
    respond_to do |format|
      format.html { render partial: 'allvenues' }
    end
  end

  def singlevenue
    respond_to do |format|
      if @error
        format.html { render :nothing => true }
      else
        format.html { render partial: 'singlevenue' }
      end
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    redirect_to "/" and return if @error
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
    redirect_to "/" and return if @error
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to venues_url, notice: "Se ha creado el lugar '#{@venue.name}'." }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        update_total_counter(@venue.id)
        format.html { redirect_to venues_url, notice: "Se ha actualizado el lugar '#{@venue.name}'." }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    name = @venue.name
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: "El lugar '#{name}' y todos sus accesos fueron eliminados." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
      @error = false
    rescue
      @error = true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:counter, :name)
    end
end
