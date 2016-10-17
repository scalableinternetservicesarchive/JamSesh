class Profile < ApplicationRecord
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    has_many :jam_group_member
    has_many :jam_group, through: :jam_group_member
    belongs_to :user
end
