class CreateRpexcDupPcodes < ActiveRecord::Migration
  def change
    create_table :rpexc_dup_pcodes do |t|
      t.references :rpexception, index: true
      t.references :player, index: true
      t.string :p_code

      t.timestamps
    end
  end
end
