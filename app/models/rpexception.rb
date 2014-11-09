class Rpexception < ActiveRecord::Base
  belongs_to :rpexception_type, foreign_key: 'rpexception_type_id'
  belongs_to :ranking_player, foreign_key: 'ranking_player_id'
  belongs_to :player, foreign_key: 'player_id'
  belongs_to :country, foreign_key: 'country_id', primary_key: 'country_id'

  has_many :rpexc_ambig_c
  has_many :rpexc_ambig_p

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
end
