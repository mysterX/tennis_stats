class AddReferencesToRankingPlayerException < ActiveRecord::Migration
  def change
    rename_table :ranking_player_exception_types, :rpexception_types
    rename_table :ranking_player_exceptions, :rpexceptions
    add_reference :rpexceptions, :rpexception_type, index: true
    add_reference :rpexceptions, :ranking_player, index: true
    add_reference :rpexceptions, :player, index: true
    add_reference :rpexceptions, :country, index: true
  end
end
