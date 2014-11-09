class DeletePlayerImports < ActiveRecord::Migration
  def change
    drop_table :player_imports
  end
end
