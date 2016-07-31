class SignUpController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      auto_login(@user)
      redirect_back_or_to root_path
      flash[:notice] = 'Регистрация успешна!'
    else
      render 'new'
      flash[:error] = @user.errors.full_messages
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
