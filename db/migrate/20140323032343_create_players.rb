class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_id
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :gender
      t.string :alt_last_name_1
      t.string :alt_last_name_2
      t.date :dob
      t.string :hand
      t.string :backhand

      t.timestamps
    end
  end
end
