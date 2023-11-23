class EffectAmount < ApplicationRecord
  validates :kaizen_type, presence: true
  validates :unit,        presence: true
  validates :amount,      presence: true
end
