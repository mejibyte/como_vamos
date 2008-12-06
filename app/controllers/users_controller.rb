class UsersController < ApplicationController

  before_filter :is_logged_in,     :only => [:edit, :edit_password, :update, :destroy]
  before_filter :find_user,        :only => [:show, :edit, :edit_password, :update, :destroy]
  before_filter :user_authorized?, :only => [:edit, :update, :destroy]


  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  def show
  end

  def edit
  end

  def update
    cookies.delete :auth_token
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to user_path(@user)
    else
      #if password wasn't sent, then we are editing the user
      if params[:user][:password].nil?
        render :action => 'edit'
      else
        render :action => 'edit_password'
      end

    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def edit_password
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
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
