class CubersController < ApplicationController
    
    def index 

    end

    def show 
        if logged_in?
            @cuber = current_cuber
            @cube_times = CubeTime.where("cuber_id = ?", @cuber.id)
            @best_cube_time = @cube_times.order(cube_time: :asc).first
            @average_cube_time = @cube_times.sum("cube_time")/@cube_times.count
            @last_5 = @cube_times.last(5)
            
            render 'show'
            #erb :"/cubers/show"
          else
      
            redirect_to "/login"
          end 
    end

    private

    def cubers_params

    end

end
