class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def update_total_counter(venue_id)
  	venue = Venue.find(venue_id)
	doors = Device.where(venue_id: venue_id)
	venue.counter = doors.map{|x| x.enter}.sum - doors.map{|x| x.leave}.sum
	venue.save!
  end
end
