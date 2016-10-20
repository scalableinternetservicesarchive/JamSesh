class Instrument < ApplicationRecord
    has_many :instrument_profile, :dependent => :destroy
end
