class CreateUsers < ActiveRecord::Migration[6.0]
  class MigrationTask < ActiveRecord::Base
    self.table_name = 'tasks'
  end

  def up
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true

    add_reference :tasks, :user, index: true
    MigrationTask.reset_column_information
    MigrationTask.find_each do |task|
      task.update!(user_id: 10_000)
    end

    change_column_null :tasks, :user_id, false
  end

  def down
    change_column_null :tasks, :user_id, true

    drop_table :users

    remove_reference :tasks, :user, index: true
  end
end
