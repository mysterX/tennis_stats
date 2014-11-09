class AddGenderToRankingPlayers < ActiveRecord::Migration
  def change
    add_column :ranking_players, :gender, :string
  end
end
