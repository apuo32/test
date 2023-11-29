class KaizenReport < ApplicationRecord
  belongs_to :user
  belongs_to :tsk_value
  belongs_to :evaluator_progress
  belongs_to :award
  belongs_to :department
end
