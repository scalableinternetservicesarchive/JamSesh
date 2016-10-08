class AddProfileToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :profile, foreign_key: true
  end
end
