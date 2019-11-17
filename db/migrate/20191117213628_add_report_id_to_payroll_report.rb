class AddReportIdToPayrollReport < ActiveRecord::Migration[6.0]
  def change
    add_column :payroll_reports, :report_id, :integer
  end
end
