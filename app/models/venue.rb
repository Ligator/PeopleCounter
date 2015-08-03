class Venue < ActiveRecord::Base
	has_many :devices, dependent: :destroy
	has_many :histories, dependent: :destroy
	validates :name, presence: true
	# validates :name, presence: true, {message: "Debe escribir un nombre"}

	def histories_simple
        hist = {}
        histories.order("created_at DESC").each do |h|   
        # histories.where(["created_at > ?", 24.hours.ago]).order("created_at DESC").each do |h|   
          hist[h.created_at] = h.counter
        end
        hist
    end

	def histories12hrs(hrs=12)
        lasthist = {}
        [*1..hrs].each do |hr|
        	x_init   = histories.where(["created_at <= ?", hr.hours.ago]).order("created_at DESC").first
        	x_init ||= histories.order("created_at ASC").first
        	x_fin    = histories.where(["created_at >= ?", hr.hours.ago]).order("created_at ASC").first
        	x_fin  ||= histories.order("created_at DESC").first
        	x0 = x_init ? x_init.created_at : Time.now
        	y0 = x_init ? x_init.counter : 0
        	x1 = x_fin  ? x_fin.created_at : Time.now
        	y1 = x_fin  ? x_fin.counter : 0
        	x  = hr.hours.ago
        	y  = linearinterpolation(x0, y0, x1, y1, x)
        	lasthist[x] = y
        end
        lasthist[0.hours.ago] = histories.order("created_at DESC").first.counter unless histories.blank?
        lasthist
    end

    def linearinterpolation(x0, y0, x1, y1, x)
    	y = y0 + (((y1-y0)*(x-x0))/(x1-x0)) unless x1==x0
    	y ||= y0
    end

end
