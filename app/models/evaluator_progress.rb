class EvaluatorProgress < ApplicationRecord
  validates :status, presence: true, uniqueness: true
end
