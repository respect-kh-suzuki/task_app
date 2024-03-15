class RenameBodyColumnToTasks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :body, :content
  end
end
