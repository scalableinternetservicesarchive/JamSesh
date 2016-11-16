require "factory_girl"
#FactoryGirl.find_definitions

FactoryGirl.create_list(:instrument, 30)
FactoryGirl.create_list(:jam_group, 200)

proficiencies = [:Newb, :Beginner, :Novice, :Intermediate, :Experienced, :Expert, :Virtuoso]
statuses = [:pending, :joined]

1000.times do |n|
  u = User.create(email: "person#{n}@example.com", password: "password", password_confirmation: "password")

  p = u.profile
  p.first_name = "First#{n}"
  p.last_name = "Last#{n}"
  p.age = (1..120).to_a.sample
  p.location = "Santa Barbara, CA"
  p.bio = "Bio #{n}"
  p.save

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
