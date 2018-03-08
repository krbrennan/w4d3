class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.ensure_session_token
      session[:session_token] = @user.session_token
      flash[:success] = 'Great success'
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def show
    @user = User.find(params[:id])
    render :show
  end



end
