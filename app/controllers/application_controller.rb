class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @profiles = Profile.all
    @profiles = @profiles.by_age_range(params[:age_low], params[:age_high]) if params[:age_low].present? or params[:age_high].present?
    @profiles = @profiles.by_location(params[:location]) if params[:location].present?
    @profiles = @profiles.by_instrument(params[:instrument]) if params[:instrument].present?
    render "home"
  end


  private

  def application_params
    params.require(:application).permit(:age_low, :age_high, :location, :instrument)
  end
  

end
