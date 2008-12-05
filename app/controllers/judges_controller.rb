class JudgesController < ApplicationController
  before_filter :is_logged_in,     :except => [:index, :show]
  before_filter :find_judge,       :only => [:show, :edit, :update, :destroy]
  before_filter :user_authorized?, :only => [:edit, :update, :destroy]

  def index
    @judges = Judge.all_sorted
  end

  def show
    @problems = @judge.problems
  end

  def new
    @judge = Judge.new
    @judge.owner_id = current_user.id
  end

  def create
    @judge = Judge.new(params[:judge])
    if @judge.save
      flash[:notice] = "Successfully created judge."
      redirect_to judges_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @judge.update_attributes(params[:judge])
      flash[:notice] = "Successfully updated judge."
      redirect_to judges_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @judge.destroy
    flash[:notice] = "Successfully destroyed judge."
    redirect_to judges_path
  end

  protected

  def user_authorized?
    redirect_unauthorized unless current_user.authorized?(@judge)
  end

  def find_judge
    @judge = Judge.find(params[:id])
  end
end
