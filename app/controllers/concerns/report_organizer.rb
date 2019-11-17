module ReportOrganizer
    def organize_report(csv, payroll_report)
        new_report = []
        csv.each do |i|
            create_row(i, payroll_report)
        end
    end

    def get_report_id(csv)
        raw_end = csv.pop
        return raw_end[:hours_worked]
    end
    
    def create_row(csv_row, payroll_report)
        row = payroll_report.rows.build(date: csv_row[:date], hours_worked: csv_row[:hours_worked], employee_id: csv_row[:employee_id], job_group: csv_row[:job_group])
        row.save!
    end
    
    #def convert_date(date)
    #    Date.parse(date)
    #end

    def generate_new_employees(employee_ids)
        new_employees = []
        employee_ids.each do |ei|
            employee = Employee.find_by(employee_id: ei)
            unless employee.present?
                new_employee = Employee.new(employee_id: ei)
                new_employee.save!
                new_employees << new_employee
            end
        end
        return new_employees if new_employees.present?
    end

    def generate_new_job_groups(job_groups)
        new_job_groups = []
        job_groups.each do |name|
            jg = JobGroup.find_by(name: name)
            unless jg.present?
                new_jg = JobGroup.new(name: name)
                new_jg.save!
                new_job_groups << new_jg
            end
        end
        return new_job_groups if new_job_groups.present?
    end
end