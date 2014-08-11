class Ranking < ActiveRecord::Base
  belongs_to :player, foreign_key: 'p_code', primary_key: 'p_code'
  belongs_to :country, foreign_key: 'c_code', primary_key: 'code_3'

  validates :r_date, presence: true
  VALID_GENDERS = ["M", "F"]
  validates :gender, presence: true, inclusion: { :in => VALID_GENDERS,
    			message: "Gender must be set to 'M' or 'F'" },
  		     length: { maximum: 1 }
  validates :rank, presence: true
  validates :player_name, presence: true
  validates :nationality, presence: true
  validates :rank_points, presence: true

end
