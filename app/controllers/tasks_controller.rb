class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.all

  end

  def calendar
    @tasks = current_user.tasks.all
  end
  def week
    beginning = Date.today.beginning_of_week
    end_week = Date.today.end_of_week
    tasks = current_user.tasks.all
    @tasks = []
    tasks.each do |task|
      if task.due_date.between?(beginning, end_week)
        @tasks << task
      end
    end
  end
  def day
    tasks = current_user.tasks.all
    @tasks = []
    tasks.each do |task|
      if task.due_date == Date.today
        @tasks << task
      end
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.due_date = Time.parse(task_params[:due_date])

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path , notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def done
   @task = current_user.tasks.find(params[:id])
   @task.done = true
   @task.save
   redirect_to tasks_path
 end
 def undo
   @task = current_user.tasks.find(params[:id])
   @task.done = false
   @task.save
   redirect_to tasks_path
 end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :done, :user_id, :due_date)
    end
  end
