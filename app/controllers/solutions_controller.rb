class SolutionsController < ApplicationController
  before_filter :is_logged_in, :except => [:index, :show]

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
      redirect_to @solution.problem
    else
      render :action => 'new'
    end
  end

  def edit
    @solution = Solution.find(params[:id])
  end

  def update
    @solution = Solution.find(params[:id])
    if @solution.update_attributes(params[:solution])
      flash[:notice] = "Successfully updated solution."
      redirect_to @solution.problem
    else
      render :action => 'edit'
    end
  end

  def destroy
    @solution = Solution.find(params[:id])
    problem = @solution.problem
    @solution.destroy
    flash[:notice] = "Successfully destroyed solution."
    redirect_to problem
  end
end
