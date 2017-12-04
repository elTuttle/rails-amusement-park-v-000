class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    #binding.pry
    @user = User.new
    @user.name = params[:user][:name]
    @user.password_digest = params[:user][:password]
    @user.happiness = params[:user][:happiness]
    @user.nausea = params[:user][:nausea]
    @user.tickets = params[:user][:tickets]
    @user.height = params[:user][:height]
    @user.admin = params[:user][:admin]
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path()
    end
  end

  def show
    if !session[:user_id].nil?
      @user = User.find(params[:id])
    else
      redirect_to '/'
    end
  end

  def sign_in
    @user = User.new
  end

  def sign_in_post
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to '/'
    end
  end

  def destroy
    if session[:user_id] != nil
      session[:user_id] = nil
    end
    redirect_to '/'
  end

  def welcome

  end

end
