class InstrumentProfile < ApplicationRecord
    belongs_to :instrument, :dependent => :destroy
    belongs_to :profile
end
