class PayrollReport < ApplicationRecord
    validates :name, presence: :true
    has_many :rows, dependent: :destroy
end
