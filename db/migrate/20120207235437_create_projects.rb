class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :account

      t.timestamps
    end
    add_index :projects, :account_id
  end
end
