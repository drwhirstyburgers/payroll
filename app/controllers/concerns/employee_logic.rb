module EmployeeLogic

    def get_employee_info(employee_id)
        return_hash = {}
        rows = Row.where(employee_id: employee_id)
        return_hash[:all_hours] = get_all_hours(rows)
        return_hash[:total_paid] = get_total_paid(rows)
        name = rows.map(&:job_group).first
        return_hash[:wage_group] = JobGroup.find_by(name: name)
        return return_hash
    end
    
    def get_all_hours(rows)
        return rows.map(&:total_hours_worked).sum
    end

    def get_total_paid(rows)
        return rows.map(&:amount_paid).sum
    end
end