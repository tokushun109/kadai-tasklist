class TasksController < ApplicationController
    before_action :set_task,only:[:show, :edit ,:update, :destroy]
    before_action :require_user_logged_in
    
    def index
        @tasks = Task.all.page(params[:page])
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :show
    end
  end

    def edit
    end

    def update
        if @task.update(task_params)
            flash[:success] = "タスクを編集しました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの編集に失敗しました"
            render :edit
        end
    end

    def destroy
        @task.destroy
        
        flash[:success] = 'タスクを削除しました'
        redirect_to tasks_url
    end
    
    private
    def task_params
        params.require(:task).permit(:content,:status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end

    
end


