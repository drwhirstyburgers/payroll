Rails.application.routes.draw do
  resources :employees
  resources :job_groups
  resources :payroll_reports
  post '/payroll_reports/return_new_items', to: 'payroll_reports#return_data'
  get '/get_report_data', to: 'payroll_reports#get_data'
  get '/sum_of_hours_worked', to: 'payroll_reports#sum_of_employee_hours'
  root to: 'payroll_reports#index'
end
