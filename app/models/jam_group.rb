class JamGroup < ApplicationRecord
  has_many :jam_group_members, :dependent => :destroy
  has_many :profiles, through: :jam_group_members
  has_many :comments, :dependent => :destroy
  alias_attribute :members, :profiles

  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  private

    def set_defaults
      self.name ||= 'Unnamed Group'
      self.image_url ||= '/img/headphone.png'
      self.description ||= 'Insert description here...'
    end
end
