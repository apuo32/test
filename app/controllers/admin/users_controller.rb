class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(id: "ASC") # idの昇順で表示
    @departments = Department.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @user = User.new # Userモデルのインスタンス作成
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 削除フラグが true に設定されている場合、削除日を更新日時に設定
      if @user.deletion_flag
        @user.update(deletion_date: @user.updated_at)
      end
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def user_params
      params.require(:user).permit(:username,
                                    :password,
                                    :employee_code,
                                    :department_id,
                                    :evaluator_id,
                                    :admin_flag,
                                    :first_evaluator_id,
                                    :second_evaluator_id,
                                    :deletion_flag)
    end
end
