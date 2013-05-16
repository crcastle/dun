class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :accomplishment_id
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, :accomplishment_id
  end
end
