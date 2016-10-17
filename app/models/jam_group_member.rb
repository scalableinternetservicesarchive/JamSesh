class JamGroupMember < ApplicationRecord
  enum status: { pending: 0, joined: 1, rejected: 2, left: 3, removed: 4 }
  belongs_to :profile
  belongs_to :jam_group
  belongs_to :invited_by, :class_name => 'Profile', :foreign_key => 'invited_by', validate: true
end
