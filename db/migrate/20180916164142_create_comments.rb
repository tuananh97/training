class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
