class Calendar < ApplicationRecord
  validates :term, presence: true
  validates :time, presence: true
  validates :first_evaluation_submission_date, presence: true
  validates :second_evaluation_submission_date, presence: true
  validates :award_date, presence: true
end
