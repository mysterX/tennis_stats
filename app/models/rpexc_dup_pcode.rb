class RpexcDupPcode < ActiveRecord::Base
  belongs_to :rpexception
  belongs_to :player

  validates :rpexception, presence: true
  validates :player, presence: true
  validates :p_code, presence: true
end
