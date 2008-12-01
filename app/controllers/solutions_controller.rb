class SolutionsController < ApplicationController
  def index
    @solutions = Solution.find(:all)
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    @solution = Solution.new

    @solution.user = current_user
    @solution.problem_id = params[:problem_id]
  end

  def create
    @solution = Solution.new(params[:solution])
    if @solution.save
      flash[:notice] = "Successfully created solution."
      redirect_to @solution
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
      redirect_to @solution
    else
      render :action => 'edit'
    end
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy
    flash[:notice] = "Successfully destroyed solution."
    redirect_to solutions_url
  end
end
