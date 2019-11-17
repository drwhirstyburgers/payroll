Rails.application.routes.draw do
  resources :payroll_reports
  root to: 'payroll_reports#new'
end
