require 'open-uri'

module PlayersHelper
  URL_PREFIX = "http://www.stevegtennis.com/"
  URL_MEN_RANK = "men-atp-rankings/"
  URL_WOMEN_RANK = "women-wta-rankings/"
  URL_RANK_SUFFIX = "all/"
#  URL_MEN_INFO = "profile-bio/men/"
#  URL_WOMEN_INFO = "profile-bio/women/"

  ITF_PLAYER_URL_PREFIX = "http://www.itftennis.com/procircuit/players/player/profile.aspx?playerid="

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
    nation = rows[5].children[1].children[0].inner_text
    hand = rows[6].children[1].children[0].inner_text
    puts "Name=" + player_name + ", DOB=" + dob + ", Country=" + nation\
    + ", Hand=" + hand
  end

  # Create a player object from the ranking player and the player's URL
  # A unique p_code will always be generated for the new player.
  # rp must be a RankingPlayer
  # Return the generated player object, or nil if one cannot be created
  def self.generate_player_from_url(rp)
    msgs = []
    url = URL_PREFIX + rp.player_url
    doc = Nokogiri::HTML(open(url))
    rows = doc.css('table#player_info tr')
    player_name = rows[0].children[1].children[0].inner_text
    dob = rows[2].children[1].children[0].inner_text
    nation = rows[5].children[1].children[0].inner_text
    hand = rows[6].children[1].children[0].inner_text
    name_array = generate_names_from_name(player_name)
    p_code = name_to_new_code(player_name)
    if !name_array.nil? && p_code.is_a?(String) && p_code.length > 0
      p = Player.new
      p.first_name = name_array[0]
      p.last_name = name_array[1]
      p.gender = rp.gender
      p_nat = p.lookup_country(nation)
      if p_nat.is_a?(Country)
        p.country = p_nat
      else
        puts "Missing country for " + p.first_name + " " + p.last_name \
        + ": [" + nation + "] putting player in unknown country"
        p.country = Country.unknown_country
      end
      p.p_code = p_code
      if !dob.nil? && dob.downcase != "Unknown" && dob != ""
        p.dob = dob
      end
      if !hand.nil? && hand != ""
        p.set_hand(hand)
      end
      p.save!
      p
    else
      nil
    end
  end

  def self.scrape_player_itf(id)
    url = ITF_PLAYER_URL_PREFIX + id.to_s
    doc = Nokogiri::HTML(open(url))
    rows = doc.css('playerDetails fl')
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

  def self.name_to_lcase_array(name)
    # Create array of name elements, converting to lower case and stripping any .
    name_array = name.split.collect { |x|
      if x[x.length - 1] == "."
        x[0...x.length - 1].downcase
      else
        x.downcase
      end
    }
  end

  def self.test_generated_names
    names=Player.all.select { |p|
      real_name = [p.first_name,
                   p.last_name
                  ]
      built_name = generate_names_from_name(p.first_name + " " + p.last_name)
      real_name != built_name
    }
    names.each { |p| 
      real_name = [p.first_name,
                   p.last_name
                  ]
      built_name = generate_names_from_name(p.first_name + " " + p.last_name)
      puts "Real_Name=" + real_name.to_s + " - Built_Name=" + built_name.to_s + "\n"
    }
    nil
  end

  def self.generate_names_from_name(sz_name)
    # An array of words from the name passed in - as is
    raw_name_array = sz_name.split
    # An array of words from the name passed in - lowercase and stripped of .
    l_name_array = name_to_lcase_array(sz_name)
    arr_len = raw_name_array.length

    if arr_len == 1
      # Last name only
      [ "", raw_name_array[0] ]
    elsif arr_len == 2
      # First and Last Name
      [ raw_name_array[0], raw_name_array[1] ]
    elsif arr_len > 2
      init_pos = last_initial_pos_in_name_array(l_name_array)
      n_suf = name_suffix(l_name_array)
      conn_pos = first_name_connector_pos(l_name_array)
      if init_pos > 0
        # First name is array up to init pos, Last name is rest of array
        [ raw_name_array[0..init_pos].join(" "),
          raw_name_array[init_pos+1...arr_len].join(" ")
          ]
      elsif !conn_pos.nil? && conn_pos > 0 && conn_pos < arr_len-1
        # First name is array up to conn pos, Last name is rest of array
        [ raw_name_array[0...conn_pos].join(" "),
          raw_name_array[conn_pos...arr_len].join(" ")
        ]
      elsif arr_len == 3
        # Default to first name is first element, last name is last two elements
        [ raw_name_array[0], raw_name_array[1...arr_len].join(" ") ]
      else
        # First name is first two elements, last name is the rest
        [ raw_name_array[0...2].join(" "), 
          raw_name_array[2...arr_len].join(" ")
        ]
      end
    else
      # No names - return nil
      nil
    end
  end

  def self.last_initial_pos_in_name_array(l_name_array)
    arr_len = l_name_array.length
    last_init_pos = l_name_array.reverse.index {
      | x | (x =~ /\A[a-z]\Z/) == 0 }
    if !last_init_pos.nil? && last_init_pos > 0 && last_init_pos < arr_len - 1
      arr_len - last_init_pos - 1
    else
      -1
    end
  end

  def self.first_name_connector_pos(l_name_array)
    l_name_array.index { |x| NAME_CONNECTORS.include?(x) }
  end

  def self.name_to_code(name)
    # byebug
    name_array = name_to_lcase_array(name)

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

  # Generate a code for a given name, and verify it is unique
  # This method will generate the codes which match the first letter of the
  # first name(s), followed by the first <n> letters of the last name,
  # creating a five-letter code. This will return an array of possible names.
  # For names with three or more separate names, the array may have multiple
  # possible codes.
  # This method then iterates through each code to see if it is unique
  # (not already assigned to another player). The first code which is unique
  # is returned. If none of the codes in the array is unique, the method will
  # take the first code from the array, and start appending _n, where
  # n represents a counter value until a unique code is generated. Once the
  # unique code is found, it will be returned.
  def self.name_to_new_code(name)
    ret_val = nil
    code_array = name_to_code(name)
    if !code_array.nil? and code_array.length > 0
      code_array.each do |a_code|
        if Player.find_by(p_code: a_code).nil?
          ret_val = a_code
          break
        end

        # If no code yet, append numeric counter
        if ret_val.nil?
          base_code = code_array[0]
          for i in 2..1000 do
            temp_code = base_code + "_" + i.to_s
            if Player.find_by(p_code: temp_code).nil?
              ret_val = temp_code
              break
            end
          end
        end
      end
    end
    ret_val
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

  def self.update_ranking_player_with_player
    ct = 0
    tot = RankingPlayer.count
    SystemLog.log("Starting update ranking player with player code, total=" \
                  + tot.to_s)
    RankingPlayer.find_each { |p|
      ct = ct + 1
      if (ct % 100 == 0)
        SystemLog.log("Player count = " + ct.to_s + "/" + tot.to_s)
      end
      p.find_player
      p.save
    }
    SystemLog.log("Ending update ranking player with player code")
  end

  def self.update_ranking_player_with_new_player
    ct = 0
    tot = RankingPlayer.where("p_code is null").count
    SystemLog.log("Starting update ranking player with new player, total=" \
                  + tot.to_s)
    RankingPlayer.where("p_code is null").find_each { |p|
#      puts p.player_name + ", " + p.nationality + ", " + p.has_unresolved_exceptions.to_s
      ct = ct + 1
      if (ct % 938 == 0)
        puts "Player count = " + ct.to_s + "/" + tot.to_s
        SystemLog.log("Player count = " + ct.to_s + "/" + tot.to_s)
        puts p.player_name + ", " + p.nationality + ", " + p.has_unresolved_exceptions.to_s
        new_player = generate_player_from_url(p)
      end
    }
  end

  def self.generate_players_for_rpexceptions
    # limit = 10
    # i = 0
    Rpexception.where("rpexception_type_id=8 and resolved=false").find_each do |rp|
      newPlayer = rp.generate_player
      # i = i + 1
      # if i >= 10
      #   break
      # end
      sleep 2
    end
  end
end
