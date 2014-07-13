class Player < ActiveRecord::Base
  validates :player_id, presence: true, uniqueness: true,
	    length: { maximum: 10, too_long: "Max length of player_id is %{count} characters" }
  validates :first_name, presence: true,
	    length: { maximum: 45, too_long: "Max length of first_name is %{count} characters" }
  validates :last_name, presence: true,
	    length: { maximum: 45, too_long: "Max length of last_name is %{count} characters" }
  validates :country, presence: true,
	    length: { maximum: 45, too_long: "Max length of country is %{count} characters" }
  VALID_GENDERS = ["M", "F"]
  validates :gender, presence: true, inclusion: { :in => VALID_GENDERS,
    			message: "Gender must be set to 'M' or 'F'" },
  		     length: { maximum: 1 }
  validates :alt_last_name_1,
	    length: { maximum: 45, too_long: "Max length of alt_last_name_1 is %{count} characters"}
  validates :alt_last_name_2,
	    length: { maximum: 45, too_long: "Max length of alt_last_name_2 is %{count} characters" }
  VALID_HANDS = [nil, "L", "R", "B"]
  validates :hand, inclusion: { :in => VALID_HANDS,
  		message: "If set, :hand must be 'L' or 'R' or 'B'" }, 
  	    length: { maximum: 1 }
  VALID_BACKHANDS = [nil, "1", "2", "B"]
  validates :backhand, inclusion: { :in => VALID_BACKHANDS,
  		message: "If set, :backhand must be '1' or '2' or 'B'" },
  	    length: { maximum: 1 }

  # Enum for gender - requires Rails 4.1.0
  # enum m_or_f: { male: "M", female: "F" }

  # Enum for player's dominant hand - requires Rails 4.1.0
  # enum left_or_right: { left: "L", right: "R" }

  # Enum for player's backhand style - requires Rails 4.1.0
  # enum bh_type: { one_handed: "1", two_handed: "2", all_double: "B" }

  before_save { self.player_id.downcase! }

  def self.hello(playerName)
    puts "Hello, ", playerName
  end

  def self.importCsv(file)
#    debugger
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      p_id = row["Player Id"].downcase
      playa = find_by(player_id: p_id) || new
#      debugger
      playa.fillFromRow(row)
      playa.save!
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
    self.player_id = row.fetch("Player Id", self.player_id)
    self.first_name = row.fetch("First Name", self.first_name)
    self.last_name = row.fetch("Last Name", self.last_name)
    self.country = row.fetch("Country", self.last_name)
    self.gender = row.fetch("Gender", self.gender)
    self.alt_last_name_1 = row.fetch("Alt Last_Name 1", self.alt_last_name_1)
    self.alt_last_name_2 = row.fetch("Alt Last Name 2", self.alt_last_name_2)
    self.dob = row.fetch("DOB", self.dob)
    self.hand = row.fetch("Hand", self.hand)
    self.backhand = row.fetch("Backhand", self.backhand)
  end

  def self.search(crit)
    if !crit.nil? and crit != ""
      where(player_id: crit.downcase).order("last_name, first_name")
    else
      all.order("last_name, first_name")
    end
  end
end
