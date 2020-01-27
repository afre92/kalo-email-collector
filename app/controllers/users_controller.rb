class UsersController < ApplicationController

  def create
    @user = User.create(user_params)

    if @user.save
      UserNotifierMailer.send_signup_email(@user).deliver
      redirect_to('/', notice: "Sign up Succesfull #{@user.first_name}, Please check your email for promotion code")
    else
      redirect_to('/', alert: 'Oops something went wrong!')
    end
  
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
