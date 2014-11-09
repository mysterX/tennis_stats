class RpexcAmbigC < ActiveRecord::Base
  belongs_to :rpexception
  belongs_to :country

  validates :rpexception, presence: true
  validates :country, presence: true
end
