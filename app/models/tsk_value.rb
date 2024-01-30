class TskValue < ApplicationRecord
  validates :value_name, presence: true, uniqueness: true

  # ホワイトリスト形式でransackで検索できる属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["deletion_flag"]
  end
end
