class CreateTraineeReports < ActiveRecord::Migration[5.2]
  def change
    create_table :trainee_reports do |t|
      t.references :report, foreign_key: true
      t.references :receiver, foreign_key: {to_table: :users}
      t.integer :status, default: 0, null: false
      t.index [:report_id, :receiver_id], unique: true, :name => 'index1'

      t.timestamps
    end
  end
end
