module UpdateUserJg
    
    def update_employees(employees)
        employees.each do |e|
            temp = Employee.find(e[:id])
            temp.name = e[:name]
            temp.save!
        end
    end 

    def update_job_groups(job_groups)
        job_groups.each do |jg|
            temp = JobGroup.find(jg[:id])
            temp.wage = jg[:wage]
            temp.save!
        end
    end

end