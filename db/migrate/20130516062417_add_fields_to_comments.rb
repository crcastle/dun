class AddFieldsToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :parent_id
      t.integer :accomplishment_id
      t.index :parent_id
      t.index :accomplishment_id

      t.remove :todo_id
    end
  end
end
