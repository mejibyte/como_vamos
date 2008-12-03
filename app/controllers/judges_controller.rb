
class JudgesController < ApplicationController
  before_filter :is_logged_in, :except => [:index, :show]

  def index
    @judges = Judge.find(:all)
  end

  def show
    @judge = Judge.find(params[:id])
    @problems = @judge.problems
  end

  def new
    if !Judge.createable_by?(current_user) then
      redirect_unauthorized(judges_path)
    else
      @judge = Judge.new
      @judge.owner_id = current_user.id
    end
  end

  def create
    if !Judge.createable_by?(current_user) then
      redirect_unauthorized(judges_path)
    else
      @judge = Judge.new(params[:judge])
      if @judge.save
        flash[:notice] = "Successfully created judge."
        redirect_to judges_path
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @judge = Judge.find(params[:id])
    redirect_unauthorized(judges_path) unless @judge.editable_by?(current_user)
  end

  def update
    @judge = Judge.find(params[:id])
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
    @judge = Judge.find(params[:id])
    if !@judge.editable_by?(current_user) then
      redirect_unauthorized(judges_path)
    else
      @judge.destroy
      flash[:notice] = "Successfully destroyed judge."
      redirect_to judges_path
    end
  end

end
