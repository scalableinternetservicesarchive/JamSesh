class AddSpotifyIdToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :spotify_id, :string
    add_column :artists, :photo_url, :string
    add_column :artists, :genres, :text
  end
end
