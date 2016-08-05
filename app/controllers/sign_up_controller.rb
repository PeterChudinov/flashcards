class SignUpController < ApplicationController
  skip_before_action :require_signin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      auto_login(@user)
      flash[:notice] = 'Регистрация успешна!'
      redirect_back_or_to root_path
    else
      flash[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
