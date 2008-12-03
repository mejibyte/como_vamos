class JudgesController < ApplicationController
  before_filter :is_logged_in, :except => [:index, :show]
  before_filter :user_must_exist, :only => [:new, :create]

  def index
    @judges = Judge.all
  end

  def show
    find_judge
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
    find_judge
    redirect_unauthorized unless @judge.editable_by?(current_user)
  end

  def update
    find_judge
    if !@judge.editable_by?(current_user) then
      redirect_unauthorized(judges_path)
    else
      if @judge.update_attributes(params[:judge])
        flash[:notice] = "Successfully updated judge."
        redirect_to judges_path
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
    find_judge
    if !@judge.editable_by?(current_user) then
      redirect_unauthorized(judges_path)
    else
      @judge.destroy
      flash[:notice] = "Successfully destroyed judge."
      redirect_to judges_path
    end
  end

  protected

  def user_must_exist
    redirect_unauthorized if current_user.nil?
  end

  def find_judge
    @judge = Judge.find(params[:id])
  end
end
