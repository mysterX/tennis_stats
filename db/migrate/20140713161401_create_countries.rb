class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
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
  end
end
