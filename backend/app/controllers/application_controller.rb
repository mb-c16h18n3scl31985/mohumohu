class ApplicationController < ActionController::API
  before_action :check_xhr_header

  helper_method :login!, :current_user

  # セッションを使用してユーザーログイン
  def login!
    session[:user_id] = @user.id
  end

  # ログイン中のユーザーを取得するインスタンス変数
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  # チームを取得するインスタンス変数
  def current_team
    if session[:team_id]
      @current_team ||= Team.find(session[:team_id])
    end
  end

  private

  def check_xhr_header
    return if request.xhr?

    render json: { error: 'forbidden' }, status: :forbidden
  end
end
