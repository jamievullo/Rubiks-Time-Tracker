class CubersController < ApplicationController

    def index 
        @cubers = Cuber.all
    end
    #loads the signup form
    def new 
        @cuber = Cuber.new
    end

    #signup
    def create
        @cuber = Cuber.new(cubers_params)
        if @cuber.save 
        session[:cuber_id] = @cuber.id
        redirect_to cuber_path(@cuber)
        else
            render :new
        end
    end

    def show 
        if logged_in?
            @cuber = current_cuber
            @cube_times = CubeTime.where("cuber_id = ?", @cuber.id)
            @best_cube_time = @cube_times.order(cube_time: :asc).first
            @average_cube_time = @cube_times.sum("cube_time")/@cube_times.count
            @last_5 = @cube_times.last(5)
            
            render :show
            
          else
      
            render :new
          end 
    end

    private

    def cubers_params
        params.require(:cuber).permit(:name, :email, :password)
    end

end
