class AddReferencesToTasks < ActiveRecord::Migration[7.1]
  def change
    change_table :tasks do |t|
      t.references :category
    end
  end
end
