class CreateRankings < ActiveRecord::Migration
  def change
    rename_column :players, :player_id, :p_code
    create_table :rankings do |t|
      t.date :r_date
      t.string :gender
      t.integer :rank
      t.string :player_name
      t.string :p_code
      t.string :nationality
      t.string :c_code
      t.integer :rank_points
      t.string :player_url
      t.string :player_msgs
      t.string :country_msgs

      t.timestamps
    end
    add_index :rankings, [:r_date, :rank, :gender]
    add_index :rankings, :player_name
  end
end
