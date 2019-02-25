class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :title
      t.integer :number_question
      t.integer :subject_id

      t.timestamps
    end
  end
end
