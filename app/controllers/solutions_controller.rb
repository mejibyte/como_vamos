class SolutionsController < ApplicationController
  before_filter :is_logged_in,     :except => [:index, :show]
  before_filter :find_solution,    :only => [:edit, :update, :destroy]
  before_filter :user_authorized?, :only => [:edit, :update, :destroy]

  def index
    redirect_to problems_path
  end

  def show
    redirect_to problems_path
  end

  def new
    if !logged_in?
      flash[:error] = "You must be logged in to submit a solution"
      redirect_to new_session_path
    else
      @solution = Solution.new

      @solution.user = current_user
      @solution.problem_id = params[:problem_id]
      if @solution.problem_id.nil?
        flash[:error] = "You must select a problem before submitting a solution"
        redirect_to problems_path
      end
    end
  end

  def create
    @solution = Solution.new(params[:solution])
    if @solution.save
      flash[:notice] = "Successfully created solution."

      #MailOffice.deliver_new_solution(User.find_by_login("andmej"), @solution, solution_url(@solution), root_url);

      redirect_to @solution.problem
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @solution.update_attributes(params[:solution])
      flash[:notice] = "Successfully updated solution."
      redirect_to @solution.problem
    else
      render :action => 'edit'
    end
  end

  def destroy
    problem = @solution.problem
    @solution.destroy
    flash[:notice] = "Successfully destroyed solution."
    redirect_to problem
  end

  protected

  def user_authorized?
    redirect_unauthorized(problem_path(@solution.problem)) unless current_user.authorized?(@solution)
  end

  def find_solution
    @solution = Solution.find(params[:id])
  end
end
