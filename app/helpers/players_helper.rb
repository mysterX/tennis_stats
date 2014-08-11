require 'open-uri'

module PlayersHelper
  URL_PREFIX = "http://www.stevegtennis.com/"
  URL_MEN_RANK = "men-atp-rankings/"
  URL_WOMEN_RANK = "women-wta-rankings/"
  URL_RANK_SUFFIX = "all/"
#  URL_MEN_INFO = "profile-bio/men/"
#  URL_WOMEN_INFO = "profile-bio/women/"

  DIR_RAW = '/data/raw'

  HEADER_RANKINGS_RAW = "Date,Gender,Rank,Player,Player_URL,Country,Points"
  HEADER_RANKINGS_PROCESSED = HEADER_RANKINGS_RAW\
  + ",Player_Id,Player_Msg,Country_Id,Country_Msg"

  NAME_SUFFIXES = { 1 => ["sr", "i", "senior", "first", "1"],
    2 => ["jr", "ii", "junior", "second", "2"],
    3 => ["third", "iii", "3rd", "3"],
    4 => ["fourth", "iv", "4th"],
    5 => ["fifth", "v", "5th"],
    6 => ["sixth", "vi", "6th"],
    7 => ["seventh", "vii", "7th"],
    8 => ["eighth", "viii", "8th"]
  }

  NAME_CONNECTORS = [ "de", "del", "la", "los", "di", "el", "di", "van", 
                      "ven", "der" ]

  def self.scrape_rankings_for_year(year, month, date, end_year, end_month, end_date)
    d = Date.new(year, month, date)
    end_d = Date.new(end_year, end_month, end_date)
    sleep_time = 1
    while (d <=> end_d) < 0
      puts "Getting rankings for " + d.inspect
     scrape_rankings_for_date(d.year, d.month, d.day)
      sleep sleep_time
      d = d + 7.day
    end
    puts "Returning final d=" + d.inspect
    d
  end

  def self.scrape_rankings_for_date(year, month, date)
    scrape_rankings('M', year, month, date, 1, 2)
    scrape_rankings('M', year, month, date, 301, 2)
    scrape_rankings('M', year, month, date, 601, 2)
    scrape_rankings('M', year, month, date, 901, 2)
    scrape_rankings('M', year, month, date, 1201, 2)
    scrape_rankings('F', year, month, date, 1, 2)
    scrape_rankings('F', year, month, date, 301, 2)
    scrape_rankings('F', year, month, date, 601, 2)
    scrape_rankings('F', year, month, date, 901, 2)
    scrape_rankings('F', year, month, date, 1201)
  end

  def self.scrape_rankings(gender, year, month, date, start_ct = 1, sleep_time = 0)
    mkdir(DIR_RAW)
    sz_file = mkfile_rankings(DIR_RAW, year)
    sz_date = "" + year.to_s + "-" + "%02d" % month + "-" + "%02d" % date
    if gender == "M"
      url = URL_PREFIX + URL_MEN_RANK + "%02d" % date  + "." + "%02d" % month\
      + "." + year.to_s + "/" + start_ct.to_s + "/" + URL_RANK_SUFFIX
    elsif gender == "F"
      url = URL_PREFIX + URL_WOMEN_RANK + "%02d" % date  + "." + "%02d" % month\
      + "." + year.to_s + "/" + start_ct.to_s + "/" + URL_RANK_SUFFIX
    else
      url = nil
      puts "ERROR: Invalid gender: " + gender
    end
    puts "URL=" + url

    if !url.nil?
      doc = Nokogiri::HTML(open(url.to_s))
      rows = doc.css('table#matchs_info tr')

      if rows.count > 1 && !rows[1].children[0].children[0].nil?
        # Interate through rows
        # c_map = Hash.new
        # c_cnt = 0
        open(sz_file, "a") { |f|
          index = 0
          rows.collect do |row|
            if index > 0
              rank = row.children[0].children[0].inner_text
              player_name = row.children[1].children[0].inner_text
              player_link = row.children[1].children[0].attributes["href"].value
              if !row.children[2].children[0].nil?
                country = row.children[2].children[0].inner_text
              else
                country = ""
              end
              pts = row.children[3].children[0].inner_text

              # Write row to file
              f << sz_date + "," + gender + "," + rank + "," + player_name\
              + "," + player_link + "," + country + "," + pts + "\n"

              #           c_obj = c_map[country]
              #           if c_obj.nil?
              #             c_cnt = c_cnt + 1
              #             if Country.count_country_code(country) > 0
              #               c_obj = Country.search_country_code(country).first
              #             elsif Country.count_country_code_alias(country) > 0
              #               c_obj = Country.search_country_code_alias(country).first
              #             else
              #               c_obj = Country.new
              #               c_obj.code_3 = country
              #               c_obj.name = ""
              #             end
              #             c_map[country] = c_obj
              # #            puts "Rank " + rank.to_s + "/" + player_name + " " \
              # #            + c_cnt.to_s + ") " + country + "=" + c_obj.code_3 + "/" +  c_obj.name
              #           end
            end
            index = index + 1
          end
        }
      end
    end

    # Sleep if given a sleep time
    if sleep_time > 0
      sleep sleep_time
    end
  end

  def self.scrape_player(player_url)
    url = URL_PREFIX + player_url
    doc = Nokogiri::HTML(open(url))
    rows = doc.css('table#player_info tr')
    player_name = rows[0].children[1].children[0].inner_text
    dob = rows[2].children[1].children[0].inner_text
    nation = rows[4].children[1].children[0].inner_text
    hand = rows[5].children[1].children[0].inner_text
    puts "Name=" + player_name + ", DOB=" + dob + ", Country=" + nation\
    + ", Hand=" + hand
  end

  def self.mkdir(dir_name)
    sz_dir = File.join(Rails.root, dir_name)
    if !Dir.exists?(sz_dir)
     Dir.mkdir(sz_dir)
    end
    sz_dir
  end

  def self.mkfile_rankings(dir_name, year)
    sz_file = File.join(Rails.root, dir_name, ("rankings_" + year.to_s + ".csv"))
    if !File.exists?(sz_file)
      open(sz_file, 'w') { |f|
        f << HEADER_RANKINGS_RAW + "\n"
      }
    end
    sz_file
  end

  def self.print_rank_dates(start_date)
    end_date = Date.today
    i_date = start_date
    while i_date <= end_date do
      puts "Date=" + i_date.year.to_s + "-" + "%02d" % i_date.month\
      + "-" + "%02d" % i_date.day
      i_date = i_date + 7.days
    end
  end

  def self.name_to_code(name)
    # Create array of name elements, converting to lower case and stripping any .
    name_array = name.split.collect { |x|
      if x[x.length - 1] == "."
        x[0...x.length - 1].downcase
      else
        x.downcase
      end
    }

    # If name ends with suffix (e.g, jr, iii, etc.) track suffix and remove
    n_suf = name_suffix(name_array)
    if n_suf > 0
      name_array.slice!(-1)
    end

    n_size = name_array.size
    # If total char length <= 5, name is sum of all chars
    l_sum = 0
    name_array.each { |x| l_sum += x.length }
    if l_sum <= 5
      code = [name_array.join]
    elsif n_size <= 1
      code = [name]
    elsif n_size == 2
      f_n = first_name_initials(name_array[0])
      rem_len = 5 - f_n.length
      code = [f_n + (name_array[1].length > rem_len ?
                     name_array[1][0,rem_len] :
                     name_array[1])]
    else
      code = []
      for i in 1...n_size
        code.concat(complex_name_to_code(name_array, i))
      end
    end

    # If name ends with suffix, duplicate all names with suffix
    if n_suf > 0
      sz_suf = n_suf.to_s
      code.concat(code.collect { |x| x + sz_suf } )
    end
    code
  end

  def self.complex_name_to_code(name_array, div_pos)
    code_array = []
    connect_name = name_array[div_pos]
    nm_len = name_array.length
    # If the first part of name array has connector names, then skip
    if (name_array[0...div_pos].count { |x| NAME_CONNECTORS.include?(x) }) > 0
      code_array
    # If any of the previous words after first are single letter, then skip
    elsif (name_array[1...div_pos].count { |x| x.length == 1 }) > 0
      code_array
    # Otherwise, look for special case connector names
    elsif connect_name == "de"
      # Special case: "de la..." or "de los..."
      if nm_len > div_pos + 2 and name_array[div_pos + 1] == "la"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "dela",
                                           name_array[div_pos + 2...nm_len])
      elsif nm_len > div_pos + 2 and name_array[div_pos + 1] == "los"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "del",
                                           name_array[div_pos + 2...nm_len])
      else
        code_array << build_connector_name(name_array[0...div_pos],
                                           "de",
                                           name_array[div_pos + 1...nm_len])
      end
    elsif connect_name == "del"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "del",
                                           name_array[div_pos + 1...nm_len])
    elsif connect_name == "di"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "di",
                                           name_array[div_pos + 1...nm_len])
    elsif connect_name == "el"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "el",
                                           name_array[div_pos + 1...nm_len])
    elsif connect_name == "la"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "la",
                                           name_array[div_pos + 1...nm_len])
    elsif connect_name == "van"
      # Special case: "van der..."
      if nm_len > div_pos + 2 and name_array[div_pos + 1] == "der"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "vd",
                                           name_array[div_pos + 2...nm_len])
      else
        # Either ...van... or ...v...
        code_array << build_connector_name(name_array[0...div_pos],
                                           "van",
                                           name_array[div_pos + 1...nm_len])
        code_array << build_connector_name(name_array[0...div_pos],
                                           "v",
                                           name_array[div_pos + 1...nm_len])
      end
    elsif connect_name == "ven"
      # Special case: "ven der..."
      if nm_len > div_pos + 2 and name_array[div_pos + 1] == "der"
        code_array << build_connector_name(name_array[0...div_pos],
                                           "vd",
                                           name_array[div_pos + 2...nm_len])
      else
        # Either ...van... or ...v...
        code_array << build_connector_name(name_array[0...div_pos],
                                           "ven",
                                           name_array[div_pos + 1...nm_len])
        code_array << build_connector_name(name_array[0...div_pos],
                                           "v",
                                           name_array[div_pos + 1...nm_len])
      end
    else
      code = first_name_initials(name_array[0])
      for i in 1...(div_pos)
        code << name_array[i][0]
      end
      max_pos = 5 - code.length
      if name_array[div_pos].length < max_pos
        code << name_array[div_pos]
        name_len = name_array.length
        for i in (div_pos + 1)...(name_len)
          if code.length < 5 and (i + 1) == name_len
            code << name_array[i][0...(5 - code.length)]
          else
            code << name_array[i][0]
          end
        end
      else
        code << name_array[div_pos][0,max_pos]
      end
      code_array << code
    end
  end

  def self.build_connector_name(first_name_array, connector, last_name_array)
    code = first_name_initials(first_name_array[0])
    first_name_array[1...first_name_array.length].each { |nm| code << nm[0] }
    code << connector
    last_name_added = false
    last_name_array.each { |nm|
      c_len = code.length
      if c_len < 5
        if (c_len + nm.length) <= 5
          code << nm
        else
          code << nm[0,5 - c_len]
        end
        last_name_added = true
      elsif !last_name_added
        # Add at least one character from last name
        code << nm[0]
        last_name_added = true
      end
    }
    code
  end

  def self.name_suffix(name_array)
    ret_val = 0
    if !name_array.nil?
      last_el = name_array[-1]
      if !last_el.nil?
        h_suf = NAME_SUFFIXES.select { |k, v| v.include?(last_el) }
        if !h_suf.nil? and !h_suf.empty?
          ret_val = h_suf.first[0]
        end
      end
    end
    ret_val
  end

  def self.first_name_initials(first_name)
    first_name.split('-').collect{ |x| x[0] }.join
  end
end
