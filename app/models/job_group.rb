class JobGroup < ApplicationRecord
    validates :name, uniqueness: true
end
