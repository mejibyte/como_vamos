class SolutionsController < ApplicationController
  def index
    @solutions = Solution.find(:all)
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    @solution = Solution.new
    @user = current_user
    if params[:problems_id].nil?
      flash[:error] = "Please select a problem first"
      redirect_to problems_path
    else
      @problem = Problem.find params[:problem_id]
      @solution.user = @user
      @solution.problem = @problem
    end
  end

  def edit
    @solution = Solution.find(params[:id])
  end

  def create
    @solution = Solution.new(params[:solution])
    if @solution.save
      flash[:notice] = 'Solution was successfully created.'
      redirect_to(@solution.problem)
    else
      render :action => "new"
    end
  end
end

  def destroy
    @solution = Solution.find(params[:id])
    @problem = @solution.problem
    @solution.destroy
    flash[:notice] = "Successfully destroyed solution."
    redirect_to problem_path(@problem)
  end

def update
  @solution = Solution.find(params[:id])

  if @solution.update_attributes(params[:solution])
    flash[:notice] = 'Solution was successfully updated.'
    redirect_to(@solution.problem)
  else
    render :action => "edit"
  end


end
