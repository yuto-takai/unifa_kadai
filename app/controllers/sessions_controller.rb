class SessionsController < ApplicationController
  def new
    redirect_to posted_photos_path if logged_in?
  end

  def create
    user = User.find_by(user_name: params[:session][:user_name].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to posted_photos_path
    else
      flash.now[:alert] = ['ユーザーIDを入力してください'] if params[:session][:user_name].blank?
      flash.now[:alert] = ['パスワードを入力してください'] if params[:session][:password].blank?
      flash.now[:alert] = ['ユーザーIDを入力してください', 'パスワードを入力してください'] if params[:session][:user_name].blank? && params[:session][:password].blank?
      flash.now[:alert] = ['ユーザーIDとパスワードが一致するユーザーが存在しません'] if user.nil?
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
