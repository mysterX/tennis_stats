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

  def self.importCsv(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      rDate = row["Date"]
      rGender = row["Gender"]
      rRank = row["Rank"]
      aRank = find_by(r_date: rDate, gender: rGender, rank: rRank) || new
      aRank.fillFromRow(row)
      aRank.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.path)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def fillFromRow(row)
    def_nation = self.country
    if def_nation.nil? || def_nation == ""
      def_nation = Country.unknown_country_code
    end
    self.r_date = row.fetch("Date", self.r_date)
    self.gender = row.fetch("Gender", self.gender)
    self.rank = row.fetch("Rank", self.rank)
    self.player_name = row.fetch("Player", self.player_name)
    self.player_url = row.fetch("Player_URL", self.player_url)
    self.nationality = row.fetch("Country", def_nation)
    self.rank_points = row.fetch("Points", self.rank_points)
  end

end
