class User < ApplicationRecord
  belongs_to :department
  belongs_to :evaluator
  belongs_to :first_evaluator, class_name: 'User', foreign_key: 'first_evaluator_id', optional: true
  belongs_to :second_evaluator, class_name: 'User', foreign_key: 'second_evaluator_id', optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
