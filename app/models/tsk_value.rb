class TskValue < ApplicationRecord
  validates :value_name, presence: true, uniqueness: true
end
