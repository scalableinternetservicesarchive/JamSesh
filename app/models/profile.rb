class Profile < ApplicationRecord
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    belongs_to :user
end
