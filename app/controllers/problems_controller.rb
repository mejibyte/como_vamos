class ProblemsController < ApplicationController
  before_filter :is_logged_in,     :except => [:index, :show]
  before_filter :find_problem,     :only => [:show, :edit, :update, :destroy]
  before_filter :user_authorized?, :only => [:edit, :update, :destroy]

  def index
    @judges = Judge.all_sorted
    @problems_by_judge = Hash.new
    for judge in @judges
      @problems_by_judge[judge] = judge.problems
    end

  end

  def show
    @judge = @problem.judge
  end

  def new
    @judge = Judge.find(params[:judge_id])
    @problem = @judge.problems.new
    @problem.owner = current_user
  end

  def create
    @problem = Problem.new(params[:problem])
    if @problem.save
      flash[:notice] = "Successfully created problem."
      redirect_to @problem
    else
      render :action => 'new'
    end
  end

  def edit
    
  end

  def update
    if @problem.update_attributes(params[:problem])
      flash[:notice] = "Successfully updated problem."
      redirect_to @problem
    else
      render :action => 'edit'
    end
  end

  def destroy
    judge = @problem.judge
    @problem.destroy
    flash[:notice] = "Successfully destroyed problem."
    redirect_to judge_path(judge)
  end
  
  
  def recent
    @problems = Problem.unique.solved_recently.limit(30).uniq
  end
  
  def unsolved
    @problems = Problem.unsolved_problems
  end


  protected

  def user_authorized?
    redirect_unauthorized unless current_user.authorized?(@problem)
  end

  def find_problem
    @problem = Problem.find(params[:id])
    if params[:id] != @problem.to_param
      headers["Status"] = "301 Moved Permanently"
      redirect_to problem_url(@problem)
    end
  end

end
