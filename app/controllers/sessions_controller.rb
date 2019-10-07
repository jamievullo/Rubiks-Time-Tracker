class SessionsController < ApplicationController

    def new 
        
    end

    def create 
        @cuber = Cuber.find_by(name: params[:name])
        if @cuber && @cuber.authenticate(params[:password])
          session[:cuber_id] = @cuber.id
            flash[:success] = "Welcome, #{@cuber.name}"
          redirect_to cuber_path(@cuber.id)
        else
            flash[:danger] = "Improper credentials given"
          redirect_to login_path
        end
    end

    def home 
    end

    #logout
    def destroy 
        session.clear
        redirect_to '/'
    end

end
