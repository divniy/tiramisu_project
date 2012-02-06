class CreateActiveBindings < ActiveRecord::Migration
  def change
    create_table :active_bindings do |t|
      t.references :user
      t.references :activable, :polymorphic => true

      t.timestamps
    end
    add_index :active_bindings, :user_id
    add_index :active_bindings, :activable_id
  end
end
