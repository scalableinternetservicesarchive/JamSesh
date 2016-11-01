class Comment < ApplicationRecord
  belongs_to :jam_group
  belongs_to :profile

  validates :comment, presence: true

  def to_s
    return "#{self.comment} - #{self.updated_at}"
  end
end
