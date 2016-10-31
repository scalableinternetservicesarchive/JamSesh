class JamGroupMember < ApplicationRecord
  enum status: { pending: 0, joined: 1, rejected: 2, left: 3, removed: 4 }
  belongs_to :profile
  belongs_to :jam_group
  belongs_to :invited_by, :class_name => 'Profile', :foreign_key => 'invited_by', validate: true

  before_destroy :destroy_jam_groups

  private

    def destroy_jam_groups
      grp = self.jam_group
      if grp.members.count == 1 and grp.jam_group_members.first == self
        grp.destroy
      end
    end
end
