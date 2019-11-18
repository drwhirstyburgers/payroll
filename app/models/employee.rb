class Employee < ApplicationRecord
    validates :employee_id, presence: true
    validates :employee_id, uniqueness: true
end
