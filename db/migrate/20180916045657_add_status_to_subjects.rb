class AddStatusToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :status, :integer, default: 0, null: false
  end
end
