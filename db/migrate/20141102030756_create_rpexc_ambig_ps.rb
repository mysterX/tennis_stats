class CreateRpexcAmbigPs < ActiveRecord::Migration
  def change
    create_table :rpexc_ambig_ps do |t|
      t.references :rpexception, index: true
      t.references :player, index: true

      t.timestamps
    end
  end
end
