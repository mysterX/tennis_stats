class RpexcAmbigP < ActiveRecord::Base
  belongs_to :rpexception
  belongs_to :player

  validates :rpexception, presence: true
  validates :player, presence: true
end
