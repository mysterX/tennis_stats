class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.text :comment

      t.timestamps
    end
  end
end
