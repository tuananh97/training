class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.integer :exam_id
      t.date :date
      t.float :score
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
