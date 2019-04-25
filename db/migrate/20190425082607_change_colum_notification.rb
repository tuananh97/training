class ChangeColumNotification < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :is_read, :is_cancel
    remove_reference :notifications, :user, index: true
    add_reference :notifications, :course, index: true, foreign_key: true
  end
end
