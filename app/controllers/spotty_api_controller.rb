require 'Spotty.rb'

#TODO: Return actual error codes/pages

class SpottyApiController < ApplicationController
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

	  genres = album.artists.first.genres.join(",")
	  render :json => {name: album.name, genres: genres, release_date: album.release_date, image: album.images[-1]}
  end
end
