class RpexcAmbigPcode < ActiveRecord::Base
  belongs_to :rpexception

  validates :rpexception, presence: true
  validates :p_code, presence: true
end
