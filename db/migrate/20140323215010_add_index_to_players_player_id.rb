class AddIndexToPlayersPlayerId < ActiveRecord::Migration
  def change
    add_index :players, :player_id, unique: true
  end
end
