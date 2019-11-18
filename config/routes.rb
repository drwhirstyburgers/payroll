Rails.application.routes.draw do
  resources :employees
  resources :job_groups
  resources :payroll_reports
  post '/payroll_reports/return_new_items', to: 'payroll_reports#return_data'
  get '/get_report_data', to: 'payroll_reports#get_data'
  root to: 'payroll_reports#new'
end
