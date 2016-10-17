class JamGroup < ApplicationRecord
  has_many :jam_group_members
  has_many :profiles, through: :jam_group_members
  alias_attribute :members, :profiles
end
