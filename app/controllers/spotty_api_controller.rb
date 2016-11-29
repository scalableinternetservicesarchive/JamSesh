#TODO: Return actual error codes/pages

class SpottyApiController < ApplicationController
  def autocomplete
	  puts "autocomplete/#{params[:term]}"
	  artists = Rails.cache.fetch("autocomplete/#{params[:term]}", expires_in: 12.hours) do
	    Spotty.autocomplete(params[:term]).map do |a|
		  {id: a.id, label: a.name, value: a.name}
		end
	  end
	  render json: artists
  end

  def song
	  if params[:song].nil?
		  render :text => "Give me a song"
		  return
	  end

	  song = Spotty.search_song(params[:song])
	  if song == nil
		  render :text => "Bad song"
		  return
	  end

	  artists = song.artists.map{|a| a.name}.join(",")
	  render :json => {name: song.name, artists: artists, album: song.album.name, image: song.album.images[-1],}
  end

  def artist
	  if params[:artist].nil?
		  render :text => "Give me an artist"
		  return
	  end

	  artist = Spotty.search_artist(params[:artist])
	  if artist.nil?
		  render :text => "Bad artist"
		  return
	  end

	  genres = artist.genres.join(",")
	  render :json => {name: artist.name, genres: genres, image: artist.images[-1],}
  end

  def album
	  if params[:album].nil?
		  render :text => "Give me an album"
		  return
	  end

	  album = Spotty.search_album(params[:album])
	  if album.nil?
		  render :text => "Bad album"
		  return
	  end

	  artists = album.artists.map{|a| a.name}.join(",")
	  genres = album.artists.first.genres.join(",")
	  render :json => {name: album.name, artists: artists, genres: genres, release_date: album.release_date, image: album.images[-1]}
  end

  def top_tracks
	  if params[:artist].nil?
		  render :text => "Give me an artist"
		  return
	  end

	  tracks = Spotty.top_tracks(params[:artist], 1)
	  if !tracks.is_a?(Array)
		  render :text => "Bad artist"
		  return
	  end
          tracks = tracks.flatten
	  render :json => {top_tracks: tracks}
  end

  def suggest_songs
	  a1 = params[:a1]
	  a2 = params[:a2]
	  if !a1.is_a?(Array) or !a1.is_a?(Array)
		  render :text => "Bad Params"
		  return
	  end

	  # initialize a new instance for dev creds
	  spotty = Spotty.new()
	  playlist = spotty.suggest_songs(a1, a2, 1)

	  render :json => {playlist: playlist}

  end
end
