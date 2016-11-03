class CreateJamGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :jam_group_members do |t|
      t.references :profile, foreign_key: true
      t.references :jam_group, foreign_key: true
      t.integer :status, default: 0
      t.integer :invited_by

      t.timestamps
    end
    add_foreign_key :jam_group_members, :profiles, column: :invited_by
  end
end
