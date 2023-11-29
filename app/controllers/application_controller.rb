class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ログインしているかテェック # ログインしていない場合ルートパスにリダイレクト
  
  protected
  # ログイン後、管理者は管理者画面、それ以外はルートパスへ遷移
  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin_flag?
      admin_users_path
    else
      root_path
    end
  end

  # ログアウト後、ログイン画面へ遷移
  def after_sign_out_path_for(resource_or_scope)
    "/users/sign_in"
  end
end
