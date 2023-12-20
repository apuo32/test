class User < ApplicationRecord
  belongs_to :department
  belongs_to :evaluator
  belongs_to :first_evaluator, class_name: 'User', foreign_key: 'first_evaluator_id', optional: true
  belongs_to :second_evaluator, class_name: 'User', foreign_key: 'second_evaluator_id', optional: true

  # ホワイトリスト形式でransackで検索できる属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["username"]
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
