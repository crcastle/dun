class DropTodosTable < ActiveRecord::Migration
  def change
    remove_index :todos, name: 'index_todos_on_complete'
    remove_index :todos, name: 'index_todos_on_project_id'
    remove_index :todos, name: 'index_todos_on_user_id'
    drop_table :todos
  end
end
