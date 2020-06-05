class TasksController < ApplicationController
  before_action :require_user_logged_in
  include SessionsHelper
  
  def index
    if logged_in?
      @tasks = current_user.task.order(id: :desc)
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
   @task = current_user.task.build
  end
  
  def create
    @task = current_user.task.build(task_params)
    
    if @task.save
      flash[:success] = '保存されました'
      redirect_to @task
    else
      flash.now[:danger] = '保存されませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = '編集が保存されました'
      redirect_to @task
    else
      flash.now[:danger] = '編集が保存されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end


private

def task_params
  params.require(:task).permit(:status, :content)
end


end
