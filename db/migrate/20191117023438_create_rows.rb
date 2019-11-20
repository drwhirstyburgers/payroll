class CreateRows < ActiveRecord::Migration[6.0]
  def change
    create_table :rows do |t|
      t.references :payroll_report, null: false, foreign_key: true
      t.string :pay_period
      t.float :amount_paid
      t.integer :employee_id
      t.string :job_group
      t.float :total_hours_worked

      t.timestamps
    end
  end
end
