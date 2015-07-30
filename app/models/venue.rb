class Venue < ActiveRecord::Base
	has_many :devices, dependent: :destroy
	validates :name, presence: true
	# validates :name, presence: true, {message: "Debe escribir un nombre"}
end
