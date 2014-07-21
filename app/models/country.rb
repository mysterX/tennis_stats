class Country < ActiveRecord::Base
  has_many :players

  # ActiveRecord validations
  validates :code_2, presence: true, uniqueness: true,
	    length: { maximum: 2, too_long: "Max length of code_2 is %{count} characteers",
                      minimum: 2, too_short: "Min length of code_2 is %{count} characteers"}
  validates :code_3, presence: true, uniqueness: true,
	    length: { maximum: 3, too_long: "Max length of code_3 is %{count} characteers",
                      minimum: 3, too_short: "Min length of code_3 is %{count} characteers"}
  validates :code_num, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :code_4, uniqueness: true, allow_blank: true,
	    length: { maximum: 4, too_long: "Max length of code_4 is %{count} characteers",
                      minimum: 4, too_short: "Min length of code_4 is %{count} characteers"}

  def add_name_alias(an_alias)
    if !(self.name_alias.nil? or self.name_alias.empty?)
      self.name_alias = (self.name_alias + "," + an_alias)
    else
      self.name_alias = an_alias
    end
  end

  def add_code_alias(an_alias)
    if !(self.code_alias.nil? or self.code_alias.empty?)
      self.code_alias = (self.code_alias + "," + an_alias)
    else
      self.code_alias = an_alias
    end
  end

  def self.importCsv(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      c_id = row["Code 3"].downcase
      ctry = find_by(code_3: c_id) || new
      ctry.fillFromRow(row)
      ctry.save!
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
    self.code_2 = row.fetch("Code 2", self.code_2)
    self.code_3 = row.fetch("Code 3", self.code_3)
    self.code_num = row.fetch("Code Num", self.code_num)
    self.name = row.fetch("Name", self.name)
    self.code_4 = row.fetch("Code 4", self.code_4)
    self.name_alias = row.fetch("Name Alias", self.name_alias)
    self.code_alias = row.fetch("Code Alias", self.code_alias)
  end

  def self.count_country_name(crit)
    find_by_sql(a_tab.project('*').join(a_c_tab).on(a_c_pred)
      .where(a_c_tab[:name].matches(crit))).count
  end

  def self.a_tab
    arel_table
  end

  def self.count_country_name(crit)
    where(a_tab[:name].matches(crit)).count
  end

  def self.search_country_name(crit)
    where(a_tab[:name].matches(crit)).order("name")
  end

  def self.count_country_name_start(crit)
    where(a_tab[:name].matches(crit + "%")).count
  end

  def self.search_country_name_start(crit)
    where(a_tab[:name].matches(crit + "%")).order("name")
  end

  def self.count_country_name_any(crit)
    where(a_tab[:name].matches("%" + crit + "%")).count
  end

  def self.search_country_name_any(crit)
    where(a_tab[:name].matches("%" + crit + "%")).order("name")
  end

  def self.count_country_code(crit)
    where(a_tab[:code_3].matches(crit)).count
  end

  def self.search_country_code(crit)
    where(a_tab[:code_3].matches(crit)).order("name")
  end

  def self.count_country_name_alias(crit)
    where(a_tab[:name_alias].matches(crit)).count
  end

  def self.search_country_name_alias(crit)
    where(a_tab[:name_alias].matches(crit)).order("name")
  end

  def self.count_country_name_alias_start(crit)
    where(a_tab[:name_alias].matches(crit + "%")).count
  end

  def self.search_country_name_alias_start(crit)
    where(a_tab[:name_alias].matches(crit + "%")).order("name")
  end

  def self.count_country_name_alias_any(crit)
    where(a_tab[:name_alias].matches("%" + crit + "%")).count
  end

  def self.search_country_name_alias_any(crit)
    where(a_tab[:name_alias].matches("%" + crit + "%")).order("name")
  end

  def self.count_country_code_alias(crit)
    where(a_tab[:code_alias].matches(crit)).count
  end

  def self.search_country_code_alias(crit)
    where(a_tab[:code_alias].matches(crit)).order("name")
  end
end
