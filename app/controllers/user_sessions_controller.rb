class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You did a good job logging in"
      redirect_to todo_lists_path
    else
      flash[:error] = "This is a sad message for you"
      render action: 'new'
    end
  end
end
