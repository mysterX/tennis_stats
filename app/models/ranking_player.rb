class RankingPlayer < ActiveRecord::Base
  belongs_to :player, foreign_key: 'p_code', primary_key: 'p_code'
  belongs_to :country, foreign_key: 'c_code', primary_key: 'code_3'

  has_many :rpexception

  VALID_GENDERS = ["M", "F"]
  validates :gender, presence: true, inclusion: { :in => VALID_GENDERS,
    			message: "Gender must be set to 'M' or 'F'" },
  		     length: { maximum: 1 }
  validates :player_name, presence: true
  validates :nationality, presence: true

  validates :p_code, uniqueness: true,
	    length: { maximum: 10, too_long: "Max length of p_code is %{count} characters" }

  def find_player
    if p_code.nil? && !has_unresolved_exceptions
      p = Player.find_by_name_and_country(self, player_name, nationality)
      if p.is_a?(Player)
        self.player = p
        self.c_code = player.get_country_code
        SystemLog.log("Player found for name=" + player_name + \
                      ", nationality=" + nationality + \
                      ": " + p.to_s)
      else
        SystemLog.log("No player found for name=" + player_name \
                      + ", nationality=" + nationality)
      end
    end
  end

  def has_unresolved_exceptions
    ret_val = false
    if !rpexception.nil?
      rpexception.each { |rpe|
        if !rpe.resolved.nil? && !rpe.resolved
          ret_val = true
          break
        end
      }
    end
    ret_val
  end

  def has_base_player
    !player.nil?
  end

  def base_player_name
    if !player.nil?
      player.first_name + " " + player.last_name
    end
  end
end
