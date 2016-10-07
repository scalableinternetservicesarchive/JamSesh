class CreateJoinTableProfileInstrument < ActiveRecord::Migration[5.0]
  def change
    create_join_table :profiles, :instruments do |t|
      # t.index [:profile_id, :instrument_id]
      # t.index [:instrument_id, :profile_id]
    end
  end
end
