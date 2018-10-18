class CreateTraineeTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :trainee_tasks do |t|
      t.references :task, foreign_key: true
      t.references :trainee, foreign_key: {to_table: :users}
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
