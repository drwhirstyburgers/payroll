module UpdateUserJg
    
    def update_employees(employees)
        employees.each do |e|
            temp = Employee.find(e[:id])
            temp.name = e[:name]
            temp.save!
        end
    end 

    def find_if_job_group_exists_and_create_new(job_groups)
        return_arr = []
        job_groups.each do |jg|
            jg_check = JobGroup.find_by(name: jg)
            if jg_check.blank?
                new_jg = JobGroup.new(name: jg)
                new_jg.save!
                return_arr << new_jg
            end
        end
        return return_arr
    end

    def update_existing_job_groups(job_groups)
        job_groups.each do |jg|
            job_group = JobGroup.find(jg[:id])
            job_group.wage = jg[:wage].to_f
            job_group.save!
        end
    end
end