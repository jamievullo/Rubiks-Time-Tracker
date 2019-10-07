class SessionsController < ApplicationController

    def new 
        @cuber = Cuber.new
        render :login
    end

    def create 
        @cuber = Cuber.find_by(name: params[:name])
        if @cuber && @cuber.authenticate(params[:password])
          session[:cuber_id] = @cuber.id
  
          redirect_to "/cubers/#{cuber.id}"
        else
          redirect_to 'login'
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
