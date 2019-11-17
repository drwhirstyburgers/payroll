class PayrollReport < ApplicationRecord
    has_many :rows, dependent: :destroy
end
