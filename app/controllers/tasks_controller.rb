class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :update, :destroy, :edit]
  include SessionsHelper
  
  def index
    @tasks = current_user.task.order(id: :desc)
  end
  
  def show
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
  end

  def update
    if @task.update(task_params)
      flash[:success] = '編集が保存されました'
      redirect_to @task
    else
      flash.now[:danger] = '編集が保存されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end


private

def task_params
  params.require(:task).permit(:status, :content)
end

def correct_user
  @task = current_user.task.find_by(id: params[:id])
  unless @task
    redirect_to root_url
  end
end

end
