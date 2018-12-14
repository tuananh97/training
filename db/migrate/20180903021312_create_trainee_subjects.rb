class CreateTraineeSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :trainee_subjects do |t|
      t.references :subject, foreign_key: true
      t.references :trainee, foreign_key: {to_table: :users}
      t.integer :course_id
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
