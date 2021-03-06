class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      flash[:success] = "Successfully logged in"
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      flash.now[:errors] = ['Bad auth credentials']
      render :new
    end
  end

  def destroy
   current_user.reset_session_token! if current_user
   session[:session_token] = nil
   redirect_to cats_url
  end




end
