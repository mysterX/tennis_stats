class AddIndexToRankingPlayers < ActiveRecord::Migration
  def change
    add_index :ranking_players, [:gender, :player_name, :nationality], unique: true
  end
end
