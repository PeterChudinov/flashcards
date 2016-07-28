class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path
      flash[:notice] = 'Вы вошли как #{params[:email]}'
    else
      flash[:notice] = 'Логин или пароль неверны'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:notice] = 'Вы успешно вышли'
  end
end
