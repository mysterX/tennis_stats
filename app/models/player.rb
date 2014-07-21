class Player < ActiveRecord::Base
  belongs_to :country, foreign_key: 'country_id', primary_key: 'country_id'

  validates :player_id, presence: true, uniqueness: true,
	    length: { maximum: 10, too_long: "Max length of player_id is %{count} characters" }
  validates :first_name, presence: true,
	    length: { maximum: 45, too_long: "Max length of first_name is %{count} characters" }
  validates :last_name, presence: true,
	    length: { maximum: 45, too_long: "Max length of last_name is %{count} characters" }
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
  validates :country, presence: true

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
    country_identifier = row.fetch("Country", "")
    self.country = lookup_country(country_identifier)
    self.gender = row.fetch("Gender", self.gender)
    self.alt_last_name_1 = row.fetch("Alt Last_Name 1", self.alt_last_name_1)
    self.alt_last_name_2 = row.fetch("Alt Last Name 2", self.alt_last_name_2)
    self.dob = row.fetch("DOB", self.dob)
    self.hand = row.fetch("Hand", self.hand)
    self.backhand = row.fetch("Backhand", self.backhand)
  end

  def lookup_country(country_identifier)
    ret_val = nil

    c_list = Country.search_country_name(country_identifier)
    if !(c_list.nil? or c_list.empty? or c_list.count > 1)
      ret_val = c_list.first
    end

    if ret_val.nil?
      c_list = Country.search_country_name_alias(country_identifier)
      if !(c_list.nil? or c_list.empty? or c_list.count > 1)
        ret_val = c_list.first
      end
    end

    if ret_val.nil?
      c_list = Country.search_country_code(country_identifier)
      if !(c_list.nil? or c_list.empty? or c_list.count > 1)
        ret_val = c_list.first
      end
    end

    if ret_val.nil?
      c_list = Country.search_country_code_alias(country_identifier)
      if !(c_list.nil? or c_list.empty? or c_list.count > 1)
        ret_val = c_list.first
      end
    end

    ret_val
  end

  def self.search(crit)
    if !crit.nil? and crit != ""
      # First attempt to match on the entire search string
      res_first = search_word(crit)
      if !(res_first.nil? or res_first.empty?)
        res_first
      else
        crit_array = crit.split
        crit_array_ct = crit_array.count
        if crit_array_ct >= 2
          search_name(crit_array)
        else
          where(id: -1)
        end
      end
    else
      all.order("last_name, first_name")
    end
  end

  def self.search_word(crit)
    if count_player_id(crit) > 0
      search_player_id(crit)
    else
      if count_last_name(crit) > 0
        search_last_name(crit)
      else
        if count_first_name(crit) > 0
          search_first_name(crit)
        else
          if count_country_code(crit) > 0
            search_country_code(crit)
          else
            if count_country_name(crit) > 0
              search_country_name(crit)
            else
              if count_last_name_start(crit) > 0
                search_last_name_start(crit)
              else
                if count_first_name_start(crit) > 0
                  search_first_name_start(crit)
                else
                  if count_country_name_start(crit) > 0
                    search_country_name_start(crit)
                  else
                    if count_last_name_any(crit) > 0
                      search_last_name_any(crit)
                    else
                      if count_first_name_any(crit) > 0
                        search_first_name_any(crit)
                      else
                        if count_country_name_any(crit) > 0
                          search_country_name_any(crit)
                        else
                          where(id: -1)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def self.a_tab
    arel_table
  end

  def self.a_c_tab
    Country.arel_table
  end

  def self.a_c_pred
    a_tab[:country_id].eq(a_c_tab[:country_id])
  end

  def self.count_player_id(crit)
    where(a_tab[:player_id].matches(crit)).count
  end

  def self.search_player_id(crit)
    where(a_tab[:player_id].matches(crit)).order("last_name, first_name")
  end

  def self.count_last_name(crit)
    where(a_tab[:last_name].matches(crit)).count
  end

  def self.search_last_name(crit)
    where(a_tab[:last_name].matches(crit)).order("last_name, first_name")
  end

  def self.count_first_name(crit)
    where(a_tab[:first_name].matches(crit)).count
  end

  def self.search_first_name(crit)
    where(a_tab[:first_name].matches(crit)).order("last_name, first_name")
  end

  def self.search_first_and_last_name(name1, name2)
    where(a_tab[:first_name].matches(name1))
    .where(a_tab[:last_name].matches(name2))
      .order("last_name, first_name")
  end

  def self.count_last_name_start(crit)
    where(a_tab[:last_name].matches(crit + "%")).count
  end

  def self.search_last_name_start(crit)
    where(a_tab[:last_name].matches(crit + "%")).order("last_name, first_name")
  end

  def self.count_first_name_start(crit)
    where(a_tab[:first_name].matches(crit + "%")).count
  end

  def self.search_first_name_start(crit)
    where(a_tab[:first_name].matches(crit + "%")).order("last_name, first_name")
  end

  def self.count_last_name_any(crit)
    where(a_tab[:last_name].matches("%" + crit + "%")).count
  end

  def self.search_last_name_any(crit)
    where(a_tab[:last_name].matches("%" + crit + "%")).order("last_name, first_name")
  end

  def self.count_first_name_any(crit)
    where(a_tab[:first_name].matches("%" + crit + "%")).count
  end

  def self.search_first_name_any(crit)
    where(a_tab[:first_name].matches("%" + crit + "%")).order("last_name, first_name")
  end

  def self.count_country_code(crit)
    c_list = Country.search_country_code(crit)
    if !(c_list.nil? or c_list.empty?)
      c_list.count
    else
      c_list = Country.search_country_code_alias(crit)
      if !(c_list.nil? or c_list.empty?)
        c_list.count
      else
        0
      end
    end
  end

  def self.search_country_code(crit)
    c_list = Country.search_country_code(crit)
    if !(c_list.nil? or c_list.empty?)
      where(country_id: c_list).order("last_name, first_name")
    else
      c_list = Country.search_country_code_alias(crit)
      if !(c_list.nil? or c_list.empty?)
        where(country_id: c_list).order("last_name, first_name")
      else
        where(id: -1)
      end
    end
  end

  def self.count_country_name(crit)
    c_list = Country.search_country_name(crit)
    if !(c_list.nil? or c_list.empty?)
      c_list.count
    else
      c_list = Country.search_country_name_alias(crit)
      if !(c_list.nil? or c_list.empty?)
        c_list.count
      else
        0
      end
    end
  end

  def self.search_country_name(crit)
    c_list = Country.search_country_name(crit)
    if !(c_list.nil? or c_list.empty?)
      where(country_id: c_list).order("last_name, first_name")
    else
      c_list = Country.search_country_name_alias(crit)
      if !(c_list.nil? or c_list.empty?)
        where(country_id: c_list).order("last_name, first_name")
      else
        where(id: -1)
      end
    end
#    find_by_sql(a_tab.project('*').join(a_c_tab).on(a_c_pred)
#      .where(a_c_tab[:name].matches(crit)).order("last_name, first_name"))
  end

  def self.count_country_name_start(crit)
    c_list = Country.search_country_name_start(crit)
    if !(c_list.nil? or c_list.empty?)
      c_list.count
    else
      c_list = Country.search_country_name_alias_start(crit)
      if !(c_list.nil? or c_list.empty?)
        c_list.count
      else
        0
      end
    end
  end

  def self.search_country_name_start(crit)
    c_list = Country.search_country_name_start(crit)
    if !(c_list.nil? or c_list.empty?)
      where(country_id: c_list).order("last_name, first_name")
    else
      c_list = Country.search_country_name_alias_start(crit)
      if !(c_list.nil? or c_list.empty?)
        where(country_id: c_list).order("last_name, first_name")
      else
        where(id: -1)
      end
    end
  end

  def self.count_country_name_any(crit)
    c_list = Country.search_country_name_any(crit)
    if !(c_list.nil? or c_list.empty?)
      c_list.count
    else
      c_list = Country.search_country_name_alias_any(crit)
      if !(c_list.nil? or c_list.empty?)
        c_list.count
      else
        0
      end
    end
  end

  def self.search_country_name_any(crit)
    c_list = Country.search_country_name_any(crit)
    if !(c_list.nil? or c_list.empty?)
      where(country_id: c_list).order("last_name, first_name")
    else
      c_list = Country.search_country_name_alias_any(crit)
      if !(c_list.nil? or c_list.empty?)
        where(country_id: c_list).order("last_name, first_name")
      else
        where(id: -1)
      end
    end
  end

  def self.search_name(crit_array)
    # Look for word ending in , - to mark last name/first name boundary
    comma_pos = crit_array.index{ |e| e.end_with?(',') }
    if !comma_pos.nil?
      name_1 = crit_array[0...comma_pos+1].join(' ')
      name_2 = crit_array[comma_pos+1...crit_array.length].join(' ')
      search_first_and_last_name(name_2, name_1[0...name_1.length-1])
    else
      ret_val = nil
      a_len = crit_array.length
      for i in 1...a_len
        name_1 = crit_array[0...i].join(' ')
        name_2 = crit_array[i...a_len].join(' ')
        s_val = search_first_and_last_name(name_1, name_2)
        if !s_val.empty?
          ret_val = s_val
          break
        end
        s_val = search_first_and_last_name(name_2, name_1)
        if !s_val.empty?
          ret_val = s_val
          break
        end
      end
      if ret_val.nil?
        ret_val = where(id: -1)
      end
      ret_val
    end
  end
end
