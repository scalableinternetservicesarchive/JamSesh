# This will guess the User class
FactoryGirl.define do

  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
    password { '12345678' }
    password_confirmation { "#{password}" }

    factory :user_with_profile do
      after(:create) do |user, evaluator|
        create(:profile, user: user)
      end
    end

    factory :user_with_instruments do
      transient do
        num_instruments 5
      end

      after(:create) do |user, evaluator|
        create(:profile_with_instruments, user: user, num_instruments: evaluator.num_instruments)
      end
    end

    factory :user_with_jam_groups do
      transient do
        num_jam_groups 5
      end

      after(:create) do |user, evaluator|
        create(:profile_with_jam_groups, user:user, num_jam_groups: evaluator.num_jam_groups)
      end
    end
  end

  factory :profile do
    user
    first_name "John"
    last_name "Doe"
    age 21

    factory :profile_with_instruments do
      transient do
        num_instruments 5
      end

      after(:create) do |profile, evaluator|
        (1..evaluator.num_instruments).each do |i|
          instr = create(:instrument)
          create(:instrument_profile, instrument: instr, profile: profile)
        end
      end
    end

    factory :profile_with_jam_groups do
      transient do
        num_jam_groups 5
      end

      after(:create) do |profile, evaluator|
        (1..evaluator.num_jam_groups).each do |i|
          create(:jam_group_member, profile: profile, invited_by: profile)
        end
      end
    end
  end

  factory :instrument do
    sequence(:name) { |n| "Instrument#{n}" }
  end

  factory :instrument_profile do
    profile { create(:profile) }
    instrument { create(:instrument) }
    proficiency "Newb"
    years 10
  end

  factory :jam_group do
    sequence(:name) { |n| "JamGroup#{n}" }
    image_url "/img/headphone.png"
    description "Insert description here..."
  end

  factory :jam_group_member do
    jam_group { create(:jam_group) }
    profile { create(:profile) }
    invited_by { create(:profile) }
  end
end
