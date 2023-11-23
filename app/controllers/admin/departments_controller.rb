class Admin::DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @department = Department.new # Departmentモデルのインスタンス作成
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to admin_departments_path
    else
      render :new
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to admin_departments_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def department_params
      params.require(:department).permit(:department_name)
    end
end
