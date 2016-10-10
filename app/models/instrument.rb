class Instrument < ApplicationRecord
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
end
