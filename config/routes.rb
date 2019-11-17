Rails.application.routes.draw do
  resources :employees
  resources :job_groups
  resources :payroll_reports
  root to: 'payroll_reports#new'
end
