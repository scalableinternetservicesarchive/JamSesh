class Profile < ApplicationRecord
    has_many :instrument_profile, :dependent => :destroy
    has_many :instrument, through: :instrument_profile
    has_many :jam_group_member, :dependent => :destroy
    has_many :jam_groups, through: :jam_group_member
    belongs_to :user

    def full_name
      "#{self.first_name} #{self.last_name}"
    end

    def display_inline
      "#{self.full_name} (#{self.user.email})"
    end
end
