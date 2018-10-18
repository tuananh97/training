class AddStatusToUserCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :user_courses, :status, :integer, default: 0, null: false
  end
end
