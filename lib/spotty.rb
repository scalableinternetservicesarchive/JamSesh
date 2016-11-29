require 'rspotify'
#require 'pry'

=begin
Uses rspotity which might be sufficient to just use on it's own tbh
Docuentation here: http://www.rubydoc.info/github/guilhermesad/rspotify/master/frames
=end

class Spotty

	# inits the class with our dev creds
	def initialize
		cli_id = '00aefcd4f0c5494e8f7638861879728e'
		cli_secret = '827b2b39322242e6a867db43c5dd41f2'
		RSpotify.authenticate(cli_id, cli_secret)
	end

	# for use with autocomplete
	def self.autocomplete(artist)
		artist = artist + "*"
		artists = RSpotify::Artist.search(artist, limit: 10)
		return artists
	end

	# returns an artist class
	def self.search_artist(artist)
		artists = RSpotify::Artist.search(artist)
		artists.each do |the_guy|
			if artist == the_guy.name
				return the_guy
			end
		end
		return nil
	end

	# returns a track class
	def self.search_song(song_name)
		results = RSpotify::Track.search(song_name)
		results.each do |the_guy|
			if the_guy.name == song_name
				return the_guy
			end
		end
		return nil
	end

	# returns an album class
	def self.search_album(album_name)
		results = RSpotify::Album.search(album_name)
		results.each do |the_guy|
			if the_guy.name == album_name
				return the_guy
			end
		end
		return nil
	end
	

	# takes either an artist class or string, returns either an artist class array or a string array
	def similar_artists(artist, str=0)
		if artist.is_a?(String)
			artist_obj = Spotty.search_artist(artist)
			if artist_obj.is_nil?
				return -1
			end
			similars = artist_obj.related_artists()

		elsif artist.is_a?(RSpotify::Artist)
			similars = artist.related_artists()

		else
			return -2
		end

		if str == 1
			similar_names = []
			similars.each{|the_guy| similar_names.push(the_guy.name)}
			return similar_names
		end

		return similars
	end


	# takes an artist string or class and returns top tracks as an array of strings or array of tracks
	def self.top_tracks(artist, str=0)
		if artist.is_a?(String)
			artist_obj = Spotty.search_artist(artist)
			if artist_obj.nil?
				return -1
			end
			top_tracks = artist_obj.top_tracks(:US)

		elsif artist.is_a?(RSpotify::Artist)
			top_tracks = artist.top_tracks(:US)

		else
			return -2
		end
		
		if str==1
			top_names = []
			top_tracks.each{|t| top_names.push(t.name)}
			return top_names
		end

		return top_tracks

	end

	def suggest_songs(a1, a2, str=0)
		if !a1.is_a?(Array) or !a2.is_a?(Array)
			return -1
		end

		# Not checking all the cases because I'm lazy as fuck
		if a1.all? { |x| x.is_a? String } and a2.all? { |x| x.is_a? String }
			artist_l1 = []
			artist_l2 = []
			a1.each do |a|
				a_obj = Spotty.search_artist(a)
				unless a_obj.nil?
					artist_l1.push(a_obj)
				end
			end

			a2.each do |a|
				a_obj = Spotty.search_artist(a)
				unless a_obj.nil?
					artist_l2.push(a_obj)
				end
			end

		elsif a1.all? { |x| x.is_a? RSpotify::Artist } and a2.all? { |x| x.is_a? RSpotify::Artist }
			artist_l1 = a1
			artist_l2 = a2


		else
			return -2
		end

		# TODO: Make this better
		in_common = []
		artist_l1.each do |pair|
			artist_l2.each do |o_pair|
				match = pair.genres & o_pair.genres
				unless match.empty?
					in_common.push(pair) unless in_common.include?(pair)
					in_common.push(o_pair) unless in_common.include?(o_pair)

				end
			end
		end

		if in_common.size() == 0
			return -3
		end
	
		in_common.each{|t| puts t.name}

		recommendations = RSpotify::Recommendations.generate(seed_artists: in_common.map(&:id))
		tracks = recommendations.tracks

		if str == 0
			return tracks
		end

		track_names = []
		tracks.each { |t| track_names.push(t.name) }
		return track_names

	end


end

