class CreateInstrumentProfiles < ActiveRecord::Migration[5.0]
  def change
      create_table :instrument_profiles do |t|
        t.belongs_to :instrument, index: true
        t.belongs_to :profile, index: true
        t.string :proficiency
        t.integer :years
        t.timestamps
      end
  end
end
