class Department < ApplicationRecord
  validates :department_name, presence: true, uniqueness: true
end
