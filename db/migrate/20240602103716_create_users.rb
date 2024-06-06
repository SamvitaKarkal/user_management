class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :uuid, null: false
      t.string :gender
      t.string :email
      t.integer :age

      t.timestamps
    end

    add_index :users, :uuid, unique: true
  end
end
