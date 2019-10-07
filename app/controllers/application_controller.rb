class ApplicationController < ActionController::Base

    helper_method :logged_in?
    helper_method :current_cuber
    helper_method :cube_types

    private 

    def logged_in?
        !!current_cuber
    end

    def current_cuber
        @current_cuber ||= Cuber.find_by(id: session[:cuber_id]) if session[:cuber_id]
    end

    def cube_types
        ["2x2", "3x3", "4x4", "5x5", "3x3-OH", "3x3-BF", "3x3-FM", "Megaminx", "Pyraminx", "Skewb", "Square-1", "6x6", "7x7"]
    end

    def authenticate 
        redirect_to login_path if !logged_in?
    end


end
