class Profile < ApplicationRecord
    
    scope :by_age, lambda { |age| where(:age => age)}
    scope :by_location, lambda { |location| where(Profile.arel_table[:location].lower.matches("%#{location.downcase}%"))}
    scope :by_instrument, lambda { |instrument| self.joins(:instrument_profile, :instrument).where(Instrument.arel_table[:name].lower.matches("%#{instrument.downcase}%")).distinct }
    
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    belongs_to :user
end
