class CreateJamGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :jam_groups do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
