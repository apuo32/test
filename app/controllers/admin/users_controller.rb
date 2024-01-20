class Admin::UsersController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック # 管理者であればこのコントローラーにアクセス可能

  def index
    if params[:q].blank?
      params[:q] = { deletion_flag_eq: 'false' }
    end

    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @users_search = User.all.order(id: "ASC").ransack(params[:q])

    # ransackのresultメソッドで@users_search内のデータをviewに表示できる形に変更
    @users_search_result = @users_search.result.page(params[:page]).per(10)

    @users = User.all.order(id: "ASC").page(params[:page]).per(10) # idの昇順で表示 #ページネーション作成
    @departments = Department.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @user = User.new # Userモデルのインスタンス作成
    @departments = Department.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
    @evaluators = Evaluator.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
    @first_and_second_evaluators = User.where(evaluator_id: [1, 2], deletion_flag: false).order(username: :asc) # evaluator_idが1か2で削除フラグがfalseのユーザーのみ取得(1,2次評価者のみ取得)
    @second_evaluators = User.where(evaluator_id: 2, deletion_flag: false).order(username: :asc) # evaluator_idが2で削除フラグがfalseのユーザーのみ取得(2次評価者のみ取得)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      @departments = Department.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
      @evaluators = Evaluator.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
      @first_and_second_evaluators = User.where(evaluator_id: [1, 2], deletion_flag: false).order(username: :asc) # evaluator_idが1か2で削除フラグがfalseのユーザーのみ取得(1,2次評価者のみ取得)
      @second_evaluators = User.where(evaluator_id: 2, deletion_flag: false).order(username: :asc) # evaluator_idが2で削除フラグがfalseのユーザーのみ取得(2次評価者のみ取得)

      @errors = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
    @departments = Department.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
    @evaluators = Evaluator.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
    @first_and_second_evaluators = User.where(evaluator_id: [1, 2], deletion_flag: false).order(username: :asc) # evaluator_idが1か2で削除フラグがfalseのユーザーのみ取得(1,2次評価者のみ取得)
    @second_evaluators = User.where(evaluator_id: 2, deletion_flag: false).order(username: :asc) # evaluator_idが2で削除フラグがfalseのユーザーのみ取得(2次評価者のみ取得)
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
      @departments = Department.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
      @evaluators = Evaluator.where(deletion_flag: false).order(id: "ASC") # idの昇順で取得
      @first_and_second_evaluators = User.where(evaluator_id: [1, 2], deletion_flag: false).order(username: :asc) # evaluator_idが1か2で削除フラグがfalseのユーザーのみ取得(1,2次評価者のみ取得)
      @second_evaluators = User.where(evaluator_id: 2, deletion_flag: false).order(username: :asc) # evaluator_idが2で削除フラグがfalseのユーザーのみ取得(2次評価者のみ取得)

      @errors = @user.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

    private
    # Strong Parameters
    def user_params
      params.require(:user).permit(:username,
                                    :password,
                                    :email,
                                    :employee_code,
                                    :department_id,
                                    :evaluator_id,
                                    :admin_flag,
                                    :first_evaluator_id,
                                    :second_evaluator_id,
                                    :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
