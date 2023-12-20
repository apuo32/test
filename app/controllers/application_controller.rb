class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ログインしているかテェック # ログインしていない場合ルートパスにリダイレクト
  
  protected
  # ログイン後、管理者は管理者画面、評価者以外はマイページ(ルートパス)、評価者は評価者画面へ遷移
  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin_flag?
      admin_users_path
    elsif current_user.evaluator_id == 4
      root_path
    else
      evaluator_path(current_user.id)
    end
  end

  # ログアウト後、ログイン画面へ遷移
  def after_sign_out_path_for(resource_or_scope)
    "/users/sign_in"
  end
end
