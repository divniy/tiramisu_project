class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :role
      t.references :owner

      t.timestamps
    end
    add_index :accounts, :owner_id
  end
end
