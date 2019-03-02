class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.text :content
      t.string :video
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
