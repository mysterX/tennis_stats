class CreateRankingPlayerExceptions < ActiveRecord::Migration
  def change
    create_table :ranking_player_exceptions do |t|
      t.boolean :resolved

      t.timestamps
    end
  end
end
