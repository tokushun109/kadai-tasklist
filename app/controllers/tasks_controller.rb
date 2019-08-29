class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = "正常にタスクを追加できました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの保存に失敗しました"
                render :new
        end
    end
    
    private
    def task_params
        params.require(:task).permit(:content)
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスクを編集しました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの編集に失敗しました"
            render :edit
        end
    end

    def destroy
    end

end
