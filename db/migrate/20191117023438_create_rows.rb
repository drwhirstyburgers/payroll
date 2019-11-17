class CreateRows < ActiveRecord::Migration[6.0]
  def change
    create_table :rows do |t|
      t.references :payroll_report, null: false, foreign_key: true
      t.string :date
      t.float :hours_worked
      t.integer :employee_id
      t.string :job_group

      t.timestamps
    end
  end
end
