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
            return_hash[gw] = all_in_this_group.map { |i| i.hours_worked * gw[:wage] if i.hours_worked.present? }.sum
            sum_of_all += return_hash[gw]
        end
        return_hash[:total] = sum_of_all
        return return_hash
    end
end