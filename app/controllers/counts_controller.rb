class CountsController < ApplicationController
	before_filter :ensureparams, only: [ :door ]

  def door
    @door.leave += params[:leave].to_i if params[:leave]
    @door.enter += params[:enter].to_i if params[:enter]
    json_response
  end

  private

  def json_response
    respond_to do |format|
      if @door.save
        update_total_counter(@door.venue.id)
        venue = Venue.find(@door.venue.id)
        format.json { render json: {message: "Contador actualizado", venue: venue, door: @door}, status: :created, location: venue_device_path(@door.venue, @door) }
      else
        format.json { render json: @door.errors, status: :unprocessable_entity }
      end
    end
  end  

  def ensureparams
    unless params[:id] and (params[:leave] or params[:enter])
      respond_to do |format|
        format.json { render json: {message: "Faltan parámetros"}, status: :unprocessable_entity }
      end
      return
    end
    @door = Device.find(params[:id])
  rescue
    respond_to do |format|
      format.json { render json: {message: "Dispositivo desconocido"}, status: :unprocessable_entity }
    end
    return
  end

end
