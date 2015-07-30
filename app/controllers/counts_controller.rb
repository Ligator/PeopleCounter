class CountsController < ApplicationController
  # before_filter :ensure_params, only: [ :decrement, :increment ]
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
        format.json { render json: {message: "Contador actualizado", venue: @door.venue, door: @door}, status: :created, location: venue_device_path(@door.venue, @door) }
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

  # def increment
  # 	@device.enter += params[:count].to_i
  # 	responsejson
  # end

  # def decrement
  #   @device.leave += params[:count].to_i
  #   responsejson
  # end


  # # def appinventorvenues
  # #   @venues = Venue.all
  # #   @venuesjson = @venues.map do |venue|
  # #     venue.name
  # #   end
  # #   respond_to do |format|
  # #     format.json { render :appinventorvenues, status: :success }
  # #   end
  # # end

  # def responsejson
  #   respond_to do |format|
  #     if @device.save
  #     	devices = Device.where(venue_id: @device.venue.id)
  #     	@device.venue.counter = devices.map{|x| x.enter}.sum - devices.map{|x| x.leave}.sum
  #     	@device.venue.save!
  #       format.json { render json: {message: "Contador actualizado", venue: @device.venue, device: @device, personas: @device.venue.counter }, status: :created, location: venue_device_path(@device.venue, @device) }
  #     else
  #       format.json { render json: @device.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def ensure_params
  # 	unless params[:device] and params[:count]
  #   	respond_to do |format|
  #       format.json { render json: {message: "Faltan parámetros"}, status: :unprocessable_entity }
  #   	end
  #   	return
  # 	end
  # 	@device = Device.find_by(name: params[:device])
  # 	unless @device
  #   	respond_to do |format|
  #       format.json { render json: {message: "Dispositivo desconocido"}, status: :unprocessable_entity }
  #   	end
  #   	return
  # 	end
  # end

end
