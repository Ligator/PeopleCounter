class Device < ActiveRecord::Base
	belongs_to :venue
	validates :name, presence: true
	validates :enter, presence: true
	validates :leave, presence: true
	# validates :name, presence: true, {:message => "Debe escribir un nombre"}
	# validates :enter, presence: true, {:message => "Debe escribir cuántas personas ya han entrado por este acceso"}
	# validates :leave, presence: true, {:message => "Debe escribir cuántas personas ya han salido por este acceso"}
end
