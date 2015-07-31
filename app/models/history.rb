class History < ActiveRecord::Base
  belongs_to :venue
  validates :counter, presence: true
end
