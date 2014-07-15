class LinkPlayerToCountry < ActiveRecord::Migration
  def change
    # Rebuild countries table using country_id as primary key
    create_table(:countries, primary_key: 'country_id', force: true) do |t|
      t.string :code_2, limit: 2, null: false
      t.string :code_3, limit: 3, null: false
      t.integer :code_num, null: false
      t.string :name, null: false
      t.string :code_4, limit: 4, null: true

      t.timestamps
    end
    add_index :countries, :code_2, unique: true
    add_index :countries, :code_3, unique: true
    add_index :countries, :code_num, unique: true
    add_index :countries, :name, unique: true
    add_index :countries, :code_4, unique: true

    # Remove existing country string field from players
    remove_column :players, :country, :string

    # Link the players table to the countries table
    add_reference :players, :country, index: true
  end
end
