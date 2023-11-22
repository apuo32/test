class Admin::DepartmentsController < ApplicationController
  def index
  end

  def new
    # Departmentモデルのインスタンス作成
    @department = Department.new
  end

  def edit
  end

  def show
  end
end
