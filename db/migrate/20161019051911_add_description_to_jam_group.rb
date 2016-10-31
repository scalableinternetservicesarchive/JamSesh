class AddDescriptionToJamGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :jam_groups, :description, :text
  end
end
