class Comment < ApplicationRecord
  belongs_to :jam_group
  belongs_to :profile
end
