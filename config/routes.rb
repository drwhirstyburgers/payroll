Rails.application.routes.draw do
  resources :employees
  resources :job_groups
  resources :payroll_reports
  post '/check_job_groups', to: 'payroll_reports#check_job_groups'
  post '/update_job_groups', to: 'payroll_reports#update_job_groups'
  get '/get_report_data', to: 'payroll_reports#get_data'
  get '/sum_of_hours_worked', to: 'payroll_reports#sum_of_employee_hours'
  root to: 'payroll_reports#index'
end
