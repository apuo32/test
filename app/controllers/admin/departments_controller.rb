class Admin::DepartmentsController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック # 管理者であればこのコントローラーにアクセス可能

  def index
    if params[:q].blank?
      params[:q] = { deletion_flag_eq: 'false' }
    end
    
    @departments_search = Department.all.order(id: "ASC").ransack(params[:q]) # idの昇順で表示
    @departments_search_result = @departments_search.result
  end

  def new
    @department = Department.new # Departmentモデルのインスタンス作成
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to admin_departments_path
    else
      @errors = @department.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      # 削除フラグが true に設定されている場合、削除日を更新日時に設定
      if @department.deletion_flag
        @department.update(deletion_date: @department.updated_at)
      end
      redirect_to admin_departments_path
    else
      @errors = @department.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

    private
    # Strong Parameters
    def department_params
      params.require(:department).permit(:department_name, :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
