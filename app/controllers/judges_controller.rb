class JudgesController < ApplicationController
  def index
    @judges = Judge.find(:all)
  end

  def show
    @judge = Judge.find(params[:id])
    @problems = @judge.problems
  end

  def new
    @judge = Judge.new
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
    @judge = Judge.find(params[:id])
  end

  def update
    @judge = Judge.find(params[:id])
    if @judge.update_attributes(params[:judge])
      flash[:notice] = "Successfully updated judge."
      redirect_to judges_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @judge = Judge.find(params[:id])
    @judge.destroy
    flash[:notice] = "Successfully destroyed judge."
    redirect_to judges_path
  end
end
