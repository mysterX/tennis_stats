class RpexceptionType < ActiveRecord::Base
  has_many :rpexceptions

  validates :desc, presence: true, uniqueness: true
  validates :exc_code, presence: true, uniqueness: true

  # Constants for known exception types
  CODE_MPC = "MPC"
  DESC_MPC = "Mismatch player and country"

  CODE_ACFPWM = "ACFPWM"
  DESC_ACFPWM = "Ambiguous country, found player with match"

  CODE_NCFP = "NCFP"
  DESC_NCFP = "No country, found player"

  CODE_ACFPWNM = "ACFPWNM"
  DESC_ACFPWNM = "Ambiguous country, found player with no match"

  CODE_APFC = "APFC"
  DESC_APFC = "Ambiguous player, found country"

  CODE_APWNC = "APWNC"
  DESC_APWNC = "Ambiguous player with no country"

  CODE_APWAC = "APWAC"
  DESC_APWAC = "Ambiguous player with ambiguous country"

  CODE_NPFC = "NPFC"
  DESC_NPFC = "No player, found country"

  CODE_NPWNC = "NPWNC"
  DESC_NPWNC = "No player with no country"

  CODE_NPWAC = "NPWAC"
  DESC_NPWAC = "No player with ambiguous country"

  CODE_APC = "APC"
  DESC_APC = "Ambiguous player code"

  CODE_DPC = "DPC"
  DESC_DPC = "Duplicate player code"

  def self.seed
    RpexceptionType.delete_all
    RpexceptionType.new(exc_code: CODE_MPC, desc: DESC_MPC).save!
    RpexceptionType.new(exc_code: CODE_ACFPWM, desc: DESC_ACFPWM).save!
    RpexceptionType.new(exc_code: CODE_NCFP, desc: DESC_NCFP).save!
    RpexceptionType.new(exc_code: CODE_ACFPWNM, desc: DESC_ACFPWNM).save!
    RpexceptionType.new(exc_code: CODE_APFC, desc: DESC_APFC).save!
    RpexceptionType.new(exc_code: CODE_APWNC, desc: DESC_APWNC).save!
    RpexceptionType.new(exc_code: CODE_APWAC, desc: DESC_APWAC).save!
    RpexceptionType.new(exc_code: CODE_NPFC, desc: DESC_NPFC).save!
    RpexceptionType.new(exc_code: CODE_NPWNC, desc: DESC_NPWNC).save!
    RpexceptionType.new(exc_code: CODE_NPWAC, desc: DESC_NPWAC).save!
    RpexceptionType.new(exc_code: CODE_APC, desc: DESC_APC).save!
    RpexceptionType.new(exc_code: CODE_DPC, desc: DESC_DPC).save!
  end

  def self.mismatch_player_and_country
    rel = where(exc_code: CODE_MPC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_country_found_player_with_match
    rel = where(exc_code: CODE_ACFPWM)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.no_country_found_player
    rel = where(exc_code: CODE_NCFP)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_country_found_player_with_no_match
    rel = where(exc_code: CODE_ACFPWNM)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_player_found_country
    rel = where(exc_code: CODE_APFC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_player_with_no_country
    rel = where(exc_code: CODE_APWNC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_player_with_ambiguous_country
    rel = where(exc_code: CODE_APWAC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.no_player_found_country
    rel = where(exc_code: CODE_NPFC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.no_player_with_no_country
    rel = where(exc_code: CODE_NPWNC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.no_player_with_ambiguous_country
    rel = where(exc_code: CODE_NPWAC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.ambiguous_player_code
    rel = where(exc_code: CODE_APC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end

  def self.duplicate_player_code
    rel = where(exc_code: CODE_DPC)
    if rel.size > 0
      rel[0]
    else
      nil
    end
  end
end
