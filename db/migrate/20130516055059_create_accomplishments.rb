class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.string :title
      t.text :description
      t.string :tags, array: true
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end

    add_index :accomplishments, :user_id
    add_index :accomplishments, :account_id
  end
end
