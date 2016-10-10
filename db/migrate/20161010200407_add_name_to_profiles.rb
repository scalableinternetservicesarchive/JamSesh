class AddNameToProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :instruments do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :profiles do |t|
      t.string :location
      t.timestamps
    end
  
    add_column :profiles, :first_name, :string, default: "Anonymous"
    add_column :profiles, :last_name, :string, default: "User"
    add_column :profiles, :age, :integer, default: 0
    add_column :profiles, :bio, :string, default: ""
    add_column :profiles, :phone, :string, default: ""
    
    add_reference :users, :profile, foreign_key: true
    add_reference :profiles, :user, index: true
    
  end
end
