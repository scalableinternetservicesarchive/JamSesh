class AddOwnedToInstrumentProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :instrument_profiles, :owned, :boolean, default: false
  end
end
