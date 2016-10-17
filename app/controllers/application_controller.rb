class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @users = User.all
    @users = User.by_age(params[:age]) if params[:age].present?
    @users = User.by_location(params[:location]) if params[:location].present?
    render "home"
  end


  private

  def application_params
    params.require(:application).permit(:age, :location, :instrument)
  end
  

end
