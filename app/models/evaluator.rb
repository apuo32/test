class Evaluator < ApplicationRecord
  validates :status, presence: true, uniqueness: true
end
