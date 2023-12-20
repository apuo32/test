class KaizenReport < ApplicationRecord
  has_many_attached :before_images
  has_many_attached :after_images

  belongs_to :user
  belongs_to :tsk_value
  belongs_to :evaluator_progress
  belongs_to :award
  belongs_to :department
  
  # ホワイトリスト形式でransackで検索できる属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["subject", "submission_date"]
  end

  def self.ransackable_associations(auth_object = nil)
    # ['user', 'award'] はKaizenReportがUserモデル、Awardモデルと関連している
    ['user', 'award']
  end

  validates :submission_date,
            :subject,
            :before_text,
            :after_text,
            :effect_comment,
            :tsk_value_id, 
            presence: true, 
            if: :submission_flag?
end
