class AddAliasesToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :code_alias, :string
    add_index :countries, :code_alias
    add_column :countries, :name_alias, :string
    add_index :countries, :name_alias
  end
end
