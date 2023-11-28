# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

100.times do |n|
  department_id = rand(1..5)
  evaluator_id = rand(1..4)

  # evaluator_idが1のユーザーのIDをランダムに取得
  first_evaluators = User.where(evaluator_id: 1).pluck(:id)
  first_evaluator_id = first_evaluators.sample

  # evaluator_idが2のユーザーのIDをランダムに取得
  second_evaluators = User.where(evaluator_id: 2).pluck(:id)
  second_evaluator_id = second_evaluators.sample

  User.create!(
    username: "test#{n + 1}人目",
    email: "test#{n + 1}@example.com",
    password: "password",
    employee_code: "#{n + 1}",
    department_id: department_id,
    evaluator_id: evaluator_id,
    first_evaluator_id: first_evaluator_id,
    second_evaluator_id: second_evaluator_id,
    admin_flag: false
  )
end