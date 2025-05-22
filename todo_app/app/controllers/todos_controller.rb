class TodosController < ApplicationController
       before_action :track_visit_time
       before_action :track_page_visits
       before_action :set_greeting

       def index
         @todos = Todo.all
       end

       def new
         @todo = Todo.new
       end

       def create
         @todo = Todo.new(todo_params)
         if @todo.save
           redirect_to todos_path, notice: "Task was successfully created!"
         else
           render :new
         end
       end

       def destroy
         @todo = Todo.find(params[:id])
         @todo.destroy
         redirect_to todos_path, notice: "Task was successfully deleted!"
       end

       private

       def todo_params
         params.require(:todo).permit(:title, :description, :status)
       end

       def track_visit_time
         @last_visit = session[:last_visit]
         session[:last_visit] = Time.current
       end

       def track_page_visits
         session[:total_visits] ||= 0
         session[:total_visits] += 1
         current_path = request.path
         page_visit = PageVisit.find_or_initialize_by(path: current_path)
         page_visit.total_visits ||= 0
         page_visit.total_visits += 1
         page_visit.save
         @total_visits = session[:total_visits]
         @page_visits = page_visit.total_visits
         @current_path = current_path
       end

       def set_greeting
         current_hour = Time.current.hour
         @greeting = case current_hour
                     when 5..11
                       "Good morning!"
                     when 12..16
                       "Good afternoon!"
                     when 17..20
                       "Good evening!"
                     else
                       "Good night!"
                     end
       end
     end