class AddNameToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :first_name, :string, default: "Anonymous"
    add_column :profiles, :last_name, :string, default: "User"
    add_column :profiles, :age, :integer, default: 0
    add_column :profiles, :bio, :string, default: ""
    add_column :profiles, :phone, :string, default: ""
    add_reference :profiles, :user, index: true
  end
end
