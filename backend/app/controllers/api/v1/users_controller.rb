class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    render json: { status: 200, data: @user }
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { status: 200, data: user }
    else
      render json: { status: 400, message: "Userの作成に失敗しました", data: user.errors }
    end
  end

  def update
    if @user.update(user_params)
      render json: { status: 200, data: @user }
    else
      render json: { status: 500, data: @user.errors }
    end
  end

  # 論理削除
  def destroy
    if @user.update(deleted_at: Time.now)
      render json: { status: 200, data: @user }
    else
      render json: { status: 500, message: "Userの削除に失敗しました" }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name,:email,:password,:password_confirmation,:remind_at,:team_id)
  end

end
