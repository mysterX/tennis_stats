class RemovePlayerMsgsFromRankingPlayer < ActiveRecord::Migration
  def change
    remove_column :ranking_players, :player_msgs, :string
  end
end
