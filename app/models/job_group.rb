class JobGroup < ApplicationRecord
    validates :wage, presence: true
    validates :name, presence: true
end
