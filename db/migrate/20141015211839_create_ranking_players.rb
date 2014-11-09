class CreateRankingPlayers < ActiveRecord::Migration
  def change
    create_table :ranking_players do |t|
      t.string :player_name
      t.string :p_code
      t.string :nationality
      t.string :c_code
      t.string :player_url
      t.text :player_msgs

      t.timestamps
    end
  end
end
