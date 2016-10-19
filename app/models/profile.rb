class Profile < ApplicationRecord
    has_many :instrument_profile
    has_many :instrument, through: :instrument_profile
    has_many :jam_group_member
    has_many :jam_groups, through: :jam_group_member
    belongs_to :user

    def display_inline
      "#{self.first_name} #{self.last_name} (#{self.user.email})"
    end
end
