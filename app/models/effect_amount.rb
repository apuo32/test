class EffectAmount < ApplicationRecord
  validates :kaizen_type, presence: true
  validates :unit,        presence: true
  validates :amount,      presence: true

  # ホワイトリスト形式でransackで検索できる属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["deletion_flag"]
  end
end
