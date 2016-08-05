class UsersController < ApplicationController
  before_action :user, only: [:show, :edit]

  def show
  end

  def edit
  end

  def update
    @user = current_user
    if @user.update!(user_params  )
      redirect_back_or_to user_path(@user)
      flash[:notice] = 'Профиль успешно обновлен'
    else
      render :action => :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :authentications_attributes)
  end
end
