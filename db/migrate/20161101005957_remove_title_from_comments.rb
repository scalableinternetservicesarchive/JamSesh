class RemoveTitleFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :title
  end
end
