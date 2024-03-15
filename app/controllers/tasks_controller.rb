class TasksController < ApplicationController
  SORT_COLUMNS = %w[id title status category_id start_date end_date]
  DEFAULT_SORT_COLUMN = 'id'
  SORT_DIRECTIONS = %w[asc desc]
  DEFAULT_SORT_DIRECTION = 'desc'

  # GET /tasks
  def index
    @tasks = params[:status].nil? ? Task.all.order("#{sort_column}") : Task.where(status: params[:status]).order("#{sort_column}")

    @sort_column = params[:sort_column]
    @sort_direction = params[:sort_direction]
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new
    @task.attributes = params.require(:task).permit(:title, :content, :status, :category_id, :start_date, :end_date)
    @task.save!

    redirect_to task_path(@task)
  rescue ActiveRecord::RecordInvalid
    render action: :new, status: :unprocessable_entity
  end

  # GET /tasks/:id
  def show
    @task = Task.find params[:id]
  end

  # GET /tasks/:id/edit
  def edit
    @task = Task.find params[:id]
  end

  # PATCH /tasks/:id
  def update
    @task = Task.find params[:id]
    @task.attributes = params.require(:task).permit(:title, :content, :status, :category_id, :start_date, :end_date)
    @task.save!

    redirect_to task_path(@task)
  rescue ActiveRecord::RecordInvalid
    render action: :edit, status: :unprocessable_entity
  end

  # DELETE /tasks/:id
  def destroy
    @task = Task.find params[:id]
    @task.destroy!
    redirect_to :tasks
  rescue ActiveRecord::RecordNotDestroyed
    flash.now[:danger] = "削除に失敗しました"
    render 'show'
  end

  private

  # ソートするカラムと順序の指定（無効な値の場合はデフォルト値を返す）
  def sort_column
    if SORT_COLUMNS.include?(params[:sort_column]) && SORT_DIRECTIONS.include?(params[:sort_direction])
      "#{params[:sort_column]} #{params[:sort_direction]}"
    else
      "#{DEFAULT_SORT_COLUMN} #{DEFAULT_SORT_DIRECTION}"
    end
  end
end
