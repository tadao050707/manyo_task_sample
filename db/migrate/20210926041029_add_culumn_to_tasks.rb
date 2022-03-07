class AddCulumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline_on, :date, default: Date.today, null: false
    add_column :tasks, :priority, :integer, default: 0, null: false
    add_column :tasks, :status, :integer, default: 0, null: false
    change_column_default :tasks, :deadline_on, nil
    change_column_default :tasks, :priority, nil
    change_column_default :tasks, :status, nil
  end
end
