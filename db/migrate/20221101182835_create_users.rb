class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Photo
      t.string :Bio
      t.integer :PostCounter

      t.timestamps
    end
    add_index :users, :Name
  end
end
