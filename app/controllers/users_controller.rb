class UsersController < ApplicationController

  before_filter :is_logged_in,     :only => [:edit, :edit_password, :update, :destroy]
  before_filter :find_user,        :only => [:show, :edit, :edit_password, :update, :destroy]
  before_filter :user_authorized?, :only => [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @user = User.find(params[:id])||(current_user if params[:id]==:current)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def new
    @user = User.new
  end

  def edit_password
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thank you for join!"
      redirect_to @user
    else
      render :action => 'new'
    end
  end

  def index
    @users = User.all
    @users.sort!{ |x, y| y.count_solved_problems <=> x.count_solved_problems }
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_path
  end

  protected

  def user_authorized?
    redirect_unauthorized unless current_user.authorized?(@user)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
