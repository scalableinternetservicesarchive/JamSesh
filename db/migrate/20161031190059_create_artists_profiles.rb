class CreateArtistsProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :artists_profiles do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :profile, index: true
    end
  end
end
