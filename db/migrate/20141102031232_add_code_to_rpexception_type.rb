class AddCodeToRpexceptionType < ActiveRecord::Migration
  def change
    add_column :rpexception_types, :exc_code, :string
  end
end
