class Award < ApplicationRecord
  validates :award_name, presence: true, uniqueness: true
end
