class CreateRpexcAmbigPcodes < ActiveRecord::Migration
  def change
    create_table :rpexc_ambig_pcodes do |t|
      t.references :rpexception, index: true
      t.string :p_code

      t.timestamps
    end
  end
end
