class DropProjectsTable < ActiveRecord::Migration
  def change
    remove_index :projects, name: 'index_projects_on_user_id'
    drop_table :projects
  end
end
