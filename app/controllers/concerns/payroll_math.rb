module PayrollMath
    def returns_all_calculations_as_hash(report_data)
        return_hash = {}
        groups_and_wages = job_groups_and_wages(report_data)
        return_hash[:groups_and_wages] = groups_and_wages
        return_hash[:sums] = gross_sums_of_groups_and_total(report_data, groups_and_wages)
        return return_hash
    end

    def job_groups_and_wages(report_data)
        groups = report_data.map { |rd| rd.job_group }.flatten(1).delete_if { |n| n == nil}.uniq
        job_groups = JobGroup.where(name: groups)
        arr = []
        job_groups.each do |jg|
            temp = {:name => jg.name, :wage => jg.wage}
            arr << temp
        end
        return arr
    end

    def gross_sums_of_groups_and_total(report_data, groups_and_wages)
        return_hash = {}
        sum_of_all = 0
        groups_and_wages.each do |gw|
            all_in_this_group = report_data.select { |rd| rd.job_group == gw[:name] }
            return_hash[gw[:name]] = all_in_this_group.map { |i| i.amount_paid }.sum
            sum_of_all += return_hash[gw[:name]]
        end
        return_hash[:total] = sum_of_all
        return return_hash
    end

    def total_hours_worked_and_money_owed(rows, employee, wage_group)
        return_hash = {}
        puts employee
        return_hash[:total_hours] = rows.select { |r| r.employee_id == employee.employee_id }.map(&:total_hours_worked).sum
        return_hash[:sum_owed] = return_hash[:total_hours] * wage_group.wage
        return_hash[:wage] = wage_group.wage
        return return_hash
    end
end