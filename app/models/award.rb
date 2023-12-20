class Award < ApplicationRecord
  validates :award_name, presence: true, uniqueness: true

  # ホワイトリスト形式でransackで検索できる属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["id", "award_name"]
  end
end
