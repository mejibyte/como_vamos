class ProblemsController < ApplicationController
  def index
    @problems = Problem.find(:all)
  end

  def show
    @problem = Problem.find(params[:id])
    @judge = @problem.judge
  end

  def new
    @judge = Judge.find(params[:judge_id])
    @problem = Problem.new
    @problem.judge_id = @judge.id
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
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update_attributes(params[:problem])
      flash[:notice] = "Successfully updated problem."
      redirect_to @problem
    else
      render :action => 'edit'
    end
  end

  def destroy
    @problem = Problem.find(params[:id])
    judge = @problem.judge
    @problem.destroy
    flash[:notice] = "Successfully destroyed problem."
    redirect_to judge_path(judge)
  end
end
