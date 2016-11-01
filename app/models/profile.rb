class Profile < ApplicationRecord
    attr_accessor :artists_list
    
    scope :by_name, lambda { |name|     first_name, last_name = name.split(' ')
                                        last_name = ' zzzz ' if not last_name
                                        where(Profile.arel_table[:first_name].lower.matches("%#{first_name.downcase}%")).or(where(Profile.arel_table[:last_name].lower.matches("%#{last_name.downcase}%"))).or(where(Profile.arel_table[:first_name].lower.matches("%#{last_name.downcase}%"))).or(where(Profile.arel_table[:last_name].lower.matches("%#{first_name.downcase}%")))

    }
    scope :by_age_range, lambda { |age_low, age_high|   age_low = '18' if age_low == ''
                                                        age_high = '999' if age_high == ''
                                                        where(:age => age_low...age_high) }
    scope :by_location, lambda { |location| where(Profile.arel_table[:location].lower.matches("%#{location.downcase}%")) }
    scope :by_instrument, lambda { |instrument| self.joins(:instrument_profile, :instrument).where(Instrument.arel_table[:name].lower.matches("%#{instrument.downcase}%")).distinct }

    has_and_belongs_to_many :artists
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    belongs_to :user
end
