class Profile < ApplicationRecord
    
    scope :by_age, lambda { |age| where(:age => age)}
    scope :by_location, lambda { |location| where(:location => location)}
    
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    belongs_to :user
end
