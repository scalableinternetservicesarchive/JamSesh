require "factory_girl"
require 'Spotty'
#FactoryGirl.find_definitions

FactoryGirl.create_list(:instrument, 30)
puts "added 30 instruments to the database"
FactoryGirl.create_list(:jam_group, 200)
puts "added 200 jam groups to the database"
instrument_ids = Instrument.all.map(&:id)
jam_group_ids = JamGroup.all.map(&:id)

proficiencies = [:Newb, :Beginner, :Novice, :Intermediate, :Experienced, :Expert, :Virtuoso]
statuses = [0, 1]
password = User.new(:password => "password").encrypted_password
letters = "abcdefghijkl"

users = []
profiles = []
instrument_profiles = []
members = []
comments = []
artists = []
artists_fields = []
artists_profiles = []

letters.each_char {|c|
	artist_arr =  Spotty.autocomplete(c)
	artist_arr.each {|artist|
		name = artist.name
		id = artist.id
		genres = artist.genres.map{|a| a}.join(",")
		photo_url = artist.images.first['url']
		artists_fields.push([name, id, photo_url, genres])
	}
}
artists_fields = artists_fields.uniq

for i in 0..artists_fields.length-1
	artists << "(#{i}, '#{artists_fields[i][0]}', NOW(), NOW(), '#{artists_fields[i][1]}', '#{artists_fields[i][2]}', '#{artists_fields[i][3]}')"
end

1000.times do |n|
  users << "(#{n}, 'person#{n}@example.com', '#{password}', NOW(), NOW())"
  profiles << "(#{n}, NOW(), NOW(), #{n}, 'First#{n}', 'Last#{n}', #{(1..120).to_a.sample}, 'Santa Barbara, CA', 'Bio #{n}')" 
  (0..artists_fields.length-1).to_a.sample(5).each do |j|
    artists_profiles << "(#{n}, #{j})"
  end
  instrument_ids.sample((1..5).to_a.sample).each do |i|
    instrument_profiles << "(#{n}, #{i}, '#{proficiencies.sample}', '#{[true, false].sample}', NOW(), NOW())" 
  end
  jam_group_ids.sample((2..10).to_a.sample).each do |j|
    members << "(#{n}, #{j}, #{n}, '#{statuses.sample}', NOW(), NOW())"

    ((10..50).to_a.sample).times do |k|
      comments << "(#{j}, #{n}, 'Comment #{k} from user #{n}', NOW(), NOW())"
    end
  end
end

User.transaction do
  User.connection.execute "INSERT INTO users (id, email, encrypted_password, created_at, updated_at) VALUES #{users.join(', ')}"
  puts "added #{users.count} users to the database"
end

Profile.transaction do
  Profile.connection.execute "INSERT INTO profiles (id, created_at, updated_at, user_id, first_name, last_name, age, location, bio) VALUES #{profiles.join(', ')}"
  puts "added #{profiles.count} user profiles to the database"
end

Artist.transaction do
  Artist.connection.execute "INSERT INTO artists (id, name, created_at, updated_at, spotify_id, photo_url, genres) VALUES #{artists.join(', ')}"
  puts "added #{artists.count} artists to the database"
end

Artist.transaction do
  Artist.connection.execute "INSERT INTO artists_profiles (artist_id, profile_id) VALUES #{artists_profiles.join(', ')}"
  puts "added #{artists_profiles.count} artists profiles to the database"
end

InstrumentProfile.transaction do
  Instrument.connection.execute "INSERT INTO instrument_profiles (profile_id, instrument_id, proficiency, owned, created_at, updated_at) VALUES #{instrument_profiles.join(', ')}"
  puts "added #{instrument_profiles.count} instrument profiles to the database"
end

JamGroupMember.transaction do
  JamGroupMember.connection.execute "INSERT INTO jam_group_members (profile_id, jam_group_id, invited_by, status, created_at, updated_at) VALUES #{members.join(', ')}"
  puts "added #{members.count} memberships to the database"
end

Comment.transaction do
  Comment.connection.execute "INSERT INTO comments (jam_group_id, profile_id, comment, created_at, updated_at) VALUES #{comments.join(', ')}"
  puts "added #{comments.count} comments to the database"
end

