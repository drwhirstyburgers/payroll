class CreatePayrollReports < ActiveRecord::Migration[6.0]
  def change
    create_table :payroll_reports do |t|
      t.datetime :date
      t.float :hours_worked
      t.integer :employee_id
      t.string :job_groub
      t.integer :report_id

      t.timestamps
    end
  end
end
