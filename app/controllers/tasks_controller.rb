class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = current_user.tasks.searched_by(params[:search], current_user).desc_sort_by(params[:sort_column], params[:direction]).newer.page(params[:page])
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private
    def set_task
      begin
        @task = current_user.tasks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to tasks_path, notice: t('common.require_correct_user')
      end
    end

    def task_params
      params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, label_ids: [])
    end
end
