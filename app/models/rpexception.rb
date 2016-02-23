class Rpexception < ActiveRecord::Base

  belongs_to :rpexception_type, foreign_key: 'rpexception_type_id'
  belongs_to :ranking_player, foreign_key: 'ranking_player_id'
  belongs_to :player, foreign_key: 'player_id'
  belongs_to :country, foreign_key: 'country_id', primary_key: 'country_id'

  has_many :rpexc_ambig_c
  has_many :rpexc_ambig_p
  has_many :rpexc_ambig_pcode
  has_many :rpexc_dup_pcode

  validates :rpexception_type, presence: true
  validates :ranking_player, presence: true

  before_save { 
    if self.resolved.nil?
      self.resolved = false
    end
    true
  }

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be a Player
  # c_info must be a Country
  def self.mismatch_player_and_country(rp, p_info, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.mismatch_player_and_country
    inst.ranking_player = rp
    inst.player = p_info
    inst.country = c_info
    inst.save!
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be a Player
  # c_info must be an array of Country
  def self.ambiguous_country_found_player_with_match(rp, p_info, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_country_found_player_with_match
    inst.ranking_player = rp
    inst.player = p_info
    inst.save!
    c_info.each { |c| 
      ex_c = RpexcAmbigC.new
      ex_c.rpexception = inst
      ex_c.country = c
      ex_c.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be a Player
  def self.no_country_found_player(rp, p_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.no_country_found_player
    inst.ranking_player = rp
    inst.player = p_info
    inst.save!
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be a Player
  # c_info must be an array of Country
  def self.ambiguous_country_found_player_with_no_match(rp, p_info, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_country_found_player_with_no_match
    inst.ranking_player = rp
    inst.player = p_info
    inst.save!
    c_info.each { |c| 
      ex_c = RpexcAmbigC.new
      ex_c.rpexception = inst
      ex_c.country = c
      ex_c.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be an array of Player
  # c_info must be a Country
  def self.ambiguous_player_found_country(rp, p_info, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_player_found_country
    inst.ranking_player = rp
    inst.country = c_info
    inst.save!
    p_info.each { |p| 
      ex_p = RpexcAmbigP.new
      ex_p.rpexception = inst
      ex_p.player = p
      ex_p.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be an array of Player
  def self.ambiguous_player_with_no_country(rp, p_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_player_with_no_country
    inst.ranking_player = rp
    inst.save!
    p_info.each { |p| 
      ex_p = RpexcAmbigP.new
      ex_p.rpexception = inst
      ex_p.player = p
      ex_p.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_info must be an array of Player
  # c_info must be an array of Country
  def self.ambiguous_player_with_ambiguous_country(rp, p_info, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_player_with_ambiguous_country
    inst.ranking_player = rp
    inst.save!
    p_info.each { |p| 
      ex_p = RpexcAmbigP.new
      ex_p.rpexception = inst
      ex_p.player = p
      ex_p.save!
    }
    c_info.each { |c| 
      ex_c = RpexcAmbigC.new
      ex_c.rpexception = inst
      ex_c.country = c
      ex_c.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # c_info must be a Country
  def self.no_player_found_country(rp, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.no_player_found_country
    inst.ranking_player = rp
    inst.country = c_info
    inst.save!
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  def self.no_player_with_no_country(rp)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.no_player_with_no_country
    inst.ranking_player = rp
    inst.save!
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # c_info must be an array of Country
  def self.no_player_with_ambiguous_country(rp, c_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.no_player_with_ambiguous_country
    inst.ranking_player = rp
    inst.save!
    c_info.each { |c| 
      ex_c = RpexcAmbigC.new
      ex_c.rpexception = inst
      ex_c.country = c
      ex_c.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_code must be an array of String
  def self.ambiguous_player_code(rp, p_info)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.ambiguous_player_code
    inst.ranking_player = rp
    inst.save!
    p_info.each { |p| 
      ex_p = RpexcAmbigPcode.new
      ex_p.rpexception = inst
      ex_p.p_code = p
      ex_p.save!
    }
    inst
  end

  # Create a ranking player exception from the info provided
  # The exception and any child objects are saved to the database.
  # rp must be a RankingPlayer
  # p_code must be a String
  # dup_p must be a Player
  def self.duplicate_player_code(rp, p_code, dup_p)
    inst = Rpexception.new
    inst.rpexception_type = RpexceptionType.duplicate_player_code
    inst.ranking_player = rp
    inst.save!
    ex_p = RpexcDupPcode.new
    ex_p.rpexception = inst
    ex_p.p_code = p_code
    ex_p.player = dup_p
    ex_p.save!
    inst
  end

  def self.a_tab
    arel_table
  end

  def self.search(crit)
    if !crit.nil? and crit != ""
      # Match on exception type and unresolved
      where(rpexception_type_id: crit.to_i)
      .where(resolved: false)
      .order("ranking_player_id")
    else
      where(resolved: false).order("ranking_player_id")
    end
  end

  def rp_name
    if !ranking_player.nil?
      ranking_player.player_name
    end
  end

  def rp_nationality
    if !ranking_player.nil?
      ranking_player.nationality
    end
  end

  def rp_url
    if !ranking_player.nil?
      ranking_player.player_url
    end
  end

  def has_base_player
    !player.nil?
  end

  def base_player_name
    if !player.nil?
      player.first_name + " " + player.last_name
    end
  end

  def base_player_code
    if !player.nil?
      player.p_code
    end
  end

  def has_base_country
    !country.nil?
  end

  def base_country_id
    if !country.nil?
      country.country_id
    else
      -1
    end
  end

  def base_country_name
    if !country.nil?
      country.name
    end
  end

  def base_country_code
    if !country.nil?
      country.code_3
    end
  end

  def base_player_country
    if !player.nil?
      player.country
    end
  end

  def base_player_country_id
    if !player.nil?
      player.get_country_id
    end
  end

  def base_player_country_name
    if !player.nil?
      player.get_country_name
    end
  end

  def base_player_country_code
    if !player.nil?
      player.get_country_code
    end
  end

  def exception_type_id
    if !rpexception_type.nil?
      rpexception_type.id
    end
  end

  # Create a new player from the information obtained from the location for
  # the player's URL. If the exception is already associated with a player,
  # then the method simply returns that player. The generated player will
  # have already been saved to the database by the generate_player_from_url
  # method which is called within.
  # This wll also link the exception to the player, and mark the exception
  # as resolved
  def generate_player
    ret_val = nil
    msg = "no changes made"
    if (!ranking_player.nil?) and !has_base_player
      ret_val = PlayersHelper.generate_player_from_url(ranking_player)
      if !ret_val.nil?
        self.player = ret_val
        if base_player_country_id != base_country_id \
          and !base_player_country.nil?
          self.country = base_player_country
        end
        self.resolved = true
        self.save!
        msg = "Created new player " + base_player_name + "/" + \
        base_player_code + "/id=" + ret_val.id.to_s
      else
        msg = "Player creation failed from url: " + rp_url
      end
    end

    SystemLog.log(msg)
    ret_val
  end

  # Set the nationality of the player contained in the ranking player
  # to the country contained in ranking player
  def set_to_nationality
    msg = "no changes made"
    if !player.nil? and !country.nil?
      if player.country != country
        msg = "Changing nationality of " + base_player_name + "/" + \
        base_player_code + " from " + base_player_country_name + "/" + \
        base_player_country_code + " to " + base_country_name + "/" + \
        base_country_code
        player.country = country
        player.save!
        self.resolved = true
        self.save!
      else
        msg = "Countries equal - " + msg
      end
    end

    SystemLog.log(msg)
  end

  # Leve the nationality of the contained player intact, but mark
  # the exception as having been resolved
  def keep_player_country
    msg = "no changes made"
    if !player.nil?
      msg = "Keeping country of " + base_player_name + "/" + \
      base_player_code + " as " + base_player_country_name + "/" + \
      base_player_country_code
      self.resolved = true
      self.save!
    end

    SystemLog.log(msg)
  end

  def update_country_with_nationality
    msg = "no changes made"
    code_alias = rp_nationality
    if !(code_alias.nil? or player.nil? or player.country.nil?)
      msg = "Adding code alias of " + code_alias + \
      " to " + base_player_country_name + "/" + \
      base_player_country_code + ", player=" + base_player_name
      player.country.add_code_alias(code_alias)
      player.country.save!
      self.country = player.country
      self.resolved = true
      self.save!
    end

    SystemLog.log(msg)
  end
end
