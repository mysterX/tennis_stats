# Predefined exception types
RpexceptionType.seed

db_file_dir = File.join(Rails.root, '/data/')

db_files = {
	"countries" => "Countries",
	"players" => "Players",
	"rankings" => "Rankings",
	"ranking_players" => "Ranking_players",
	"rpexceptions" => "Rpexceptions"
}

db_files.each do |k,v|
	db_stmt = "copy " + k + " from '" + \
	db_file_dir + v + "_psql.csv' with (format csv, header 1);"
	ActiveRecord::Base.connection.execute(db_stmt)
end