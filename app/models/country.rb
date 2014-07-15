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
  end

end
