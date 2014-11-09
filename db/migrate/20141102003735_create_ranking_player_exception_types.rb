class CreateRankingPlayerExceptionTypes < ActiveRecord::Migration
  def change
    create_table :ranking_player_exception_types do |t|
      t.string :desc

      t.timestamps
    end
  end
end
