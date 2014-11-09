class CreateRpexcAmbigCs < ActiveRecord::Migration
  def change
    create_table :rpexc_ambig_cs do |t|
      t.references :rpexception, index: true
      t.references :country, index: true

      t.timestamps
    end
  end
end
