require "factory_girl"
#FactoryGirl.find_definitions

FactoryGirl.create_list(:instrument, 30)
FactoryGirl.create_list(:jam_group, 200)

proficiencies = [:Newb, :Beginner, :Novice, :Intermediate, :Experienced, :Expert, :Virtuoso]
statuses = [:pending, :joined]

users = []
profiles = []
1000.times do |n|
  User.connection.execute "INSERT INTO users (`id`, `email`, `encrypted_password`, `created_at`, `updated_at`) VALUES (#{n}, 'person#{n}@example.com', '#{User.new(:password => "password").encrypted_password}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
end

1000.times do |n|
  Profile.connection.execute "INSERT INTO profiles (`id`, `created_at`, `updated_at`, `user_id`, `first_name`, `last_name`, `age`, `location`, `bio`) VALUES (#{n}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, #{n}, 'First#{n}', 'Last#{n}', #{(1..120).to_a.sample}, 'Santa Barbara, CA', 'Bio #{n}')" 
end

1000.times do |n|
  p = Profile.find(n)
  Instrument.limit((1..5).to_a.sample).order("RANDOM()").each do |i|
    ip = InstrumentProfile.new
    ip.profile = p
    ip.instrument = i
    ip.proficiency = proficiencies.sample
    ip.owned = [true, false].sample
    ip.save
  end

  JamGroup.limit((2..10).to_a.sample).order("RANDOM()").each do |j|
    jgm = JamGroupMember.new
    jgm.profile = p
    jgm.jam_group = j
    jgm.invited_by = Profile.offset(rand(Profile.count)).first
    jgm.status = statuses.sample
    jgm.save

    ((10..50).to_a.sample).times do |k|
      c = Comment.new
      c.jam_group = j
      c.profile = p
      c.comment = "Comment #{k} from #{p.full_name}"
      c.save
    end
  end

end

