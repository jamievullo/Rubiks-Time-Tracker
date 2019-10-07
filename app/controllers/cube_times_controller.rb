class CubeTimesController < ApplicationController

    before_action :authenticate

    def index 
        if logged_in?
            @cuber = current_cuber
            render :show
        else  
            redirect_to login_path
        end
    end

    def new 
            @cuber = current_cuber
        if logged_in?
            render :new
            #erb :"/cube_times/new"
        else  
            redirect_to login_path
        end
    end

    def create 
        if logged_in?
            #raise params.inspect
            if params[:cube_time] == "" || !params.include?(:cubetype)
                render :new
            #   redirect '/cube_times/new'
            else
                if is_number?(params[:cube_time])
                    @cube_time = CubeTime.create(cube_time: params[:cube_time], cube_type: params[:cubetype])
                    @cube_time.cuber_id = current_cuber.id
                    if @cube_time.save
                
                        redirect_to cube_times_path(@cube_time.id)
                    else  
                        render :new
                    end
                else
                  #redirect :"/sessions/error"
                end
            end
        else
            redirect_to login_path
        end
    end

    def cube_type 
        if logged_in? 
            @type = params[:cube_type]
            @cuber = current_cuber
            @times = CubeTime.where(cuber_id: @cuber.id).where(cube_type: params[:cube_type])
            if @times.empty? 
              redirect_to cube_times_path
            else
             @best_cube_time = @times.order(cube_time: :asc).first
             @average_cube_time = @times.sum("cube_time")/@times.count
             @last_5 = @times.last(5)
             erb :"/cube_times/type" 
            end
          else
            redirect_to login_path
          
          end  
    end

    def edit
        if logged_in?
            @cuber = current_cuber
            @cube_time = CubeTime.find_by_id(params[:id])
            if @cube_time && @cube_time.cuber_id == current_cuber.id
                render cube_times_path(@cube_time.id)
            else
                redirect_to cube_times_path
            end
        else
            redirect_to login_path
        end
        erb :"/cube_times/edit" 
    end

    def update
        if logged_in?
            @cuber = current_cuber
            @cube_time = CubeTime.find_by_id(params[:id]) 
            @cube_time.cube_time = params[:cube_time]
            @cube_time.save
          
            redirect "/cube_times/#{@cube_time.id}"
        else
            redirect_to login_path
        end
    end

    def destroy
        if logged_in?
            @cuber = current_cuber
            @cube_time = CubeTime.find_by_id(params[:id])
            @cube_time.destroy
      
            redirect "/cubers/show"
        else 
            redirect_to login_path   
        end
    end

    private

    def cube_times_params

    end
    
end
