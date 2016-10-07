class AddProficiencyToInstruments < ActiveRecord::Migration[5.0]
  def change
    add_column :instruments, :proficiency, :integer
  end
end
