module ReportOrganizer

    def organize_report(csv, payroll_report)
        new_report = []
        sorted_by_date = sort_data_by_date(csv)
        summed_and_consolidated = sum_and_consolidate(sorted_by_date)
        proper_format = get_amount_paid_and_create_hash(summed_and_consolidated)
        proper_format.each do |i|
            create_row(i, payroll_report)
        end
    end

    def get_report_id(csv)
       the_one = csv.select { |r| r[:date] == "report id" }.first
       return the_one[:hours_worked]
    end

    def sort_data_by_date(csv)
        return_arr = []
        csv.delete_if { |r| r[:employee_id] == '' || r[:employee_id] == nil }
        employees = csv.map { |r| r[:employee_id].to_s }.uniq
        sorted_by_employee = csv.group_by { |r| r[:employee_id] }
        employees.each do |e|
            sorted_by_employee[e].each { |r| r[:date] = Date.parse(r[:date]) }
            dates = sorted_by_employee[e].map { |r| r[:date] }.sort
            months = dates.map { |d| d.month }.uniq
            months.each do |m|
                last_day = Time.days_in_month(m)
                if m == 2
                    last_day += 1
                end
                first_half = sorted_by_employee[e].select { |d| d[:date].day.between?(1, 15) && d[:date].month == m }
                first_half.each do |r|
                    year = r[:date].year
                    temp = {:range => "1/#{m}/#{year}-15/#{m}/#{year}", :employee_id => r[:employee_id], :hours_worked => r[:hours_worked], :job_group => r[:job_group]}
                    return_arr << temp
                end
                second_half = sorted_by_employee[e].select { |d| d[:date].day.between?(16, last_day) && d[:date].month == m }
                second_half.each do |r|
                    last_day = Time.days_in_month(m)
                    year = r[:date].year
                    if m == 2 && year % 4 == 0
                        last_day = 29
                    end
                    temp = {:range => "16/#{m}/#{year}-#{last_day}/#{m}/#{year}", :employee_id => r[:employee_id], :hours_worked => r[:hours_worked], :job_group => r[:job_group]}
                    return_arr << temp
                end
            end
        end
        return return_arr
    end
            
    def sum_and_consolidate(data)
        return_arr = []
        employees = data.map { |r| r[:employee_id] }.uniq
        ranges = data.map { |r| r[:range] }.uniq
        employees.each do |e|
            ranges.each do |r|
                temp_h = {}
                temp = data.select { |d| d[:employee_id] == e && d[:range] == r }
                if temp.present?
                    group = temp.map { |r| r[:job_group] }.uniq
                    unless group.count > 1
                        sum_of_hours = temp.map { |r| r[:hours_worked].to_f }
                        sum_of_hours = sum_of_hours.sum
                        temp_h[:range] = r
                        temp_h[:employee_id] = e
                        temp_h[:hours_worked] = sum_of_hours
                        temp_h[:job_group] = group.first
                        return_arr << temp_h if temp_h[:hours_worked] > 0
                    else
                        group.each do |g|
                            new_temps = data.select { |d| d[:employee_id] == e && d[:range] == r && d[:job_group] == g }
                            new_temps.each do |nt|
                                sum_of_hours = temp.map { |r| r[:hours_worked].to_f }
                                sum_of_hours = sum_of_hours.sum
                                temp_h[:range] = r
                                temp_h[:employee_id] = e
                                temp_h[:hours_worked] = sum_of_hours
                                temp_h[:job_group] = g
                                return_arr << temp_h if temp_h[:hours_worked] > 0
                            end
                        end
                    end
                end
            end
        end
        return return_arr.uniq
    end

    def get_amount_paid_and_create_hash(summed_and_consolidated)
        return_arr = []
        jg = summed_and_consolidated.map { |r| r[:job_group] }.uniq
        job_groups = JobGroup.where(name: jg) #refactored so that not making N+1 Query
        summed_and_consolidated.each do |r|
            job_group = job_groups.select { |j| r[:job_group] == j.name }.first
            temp = {}
            temp[:range] = r[:range]
            temp[:employee_id] = r[:employee_id]
            temp[:amount_paid] = r[:hours_worked] * job_group.wage if r[:hours_worked] != nil
            temp[:job_group] = job_group.name
            temp[:total_hours_worked] = r[:hours_worked]
            return_arr << temp
        end
        return return_arr.uniq
    end


    
    def create_row(csv_row, payroll_report)
        #date = convert_date(csv_row[:date])
        #convert_date(date)
        row = payroll_report.rows.build(pay_period: csv_row[:range], employee_id: csv_row[:employee_id], amount_paid: csv_row[:amount_paid], job_group: csv_row[:job_group], total_hours_worked: csv_row[:total_hours_worked])
        row.save!
    end
    
    #def convert_date(date)
    #    if date != nil || date != ''
    #        unless date.include?(['a'..'z'])
    #            puts date
    #            return Date.parse(date)
    #        end
    #    end
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