json.extract! payroll_report, :id, :date, :hours_worked, :employee_id, :job_groub, :report_id, :created_at, :updated_at
json.url payroll_report_url(payroll_report, format: :json)
