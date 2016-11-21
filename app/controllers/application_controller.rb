class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @profiles = Profile
    @profiles = @profiles.where("first_name LIKE ?", "%#{params[:first_name]}%") if params[:first_name].present?
    @profiles = @profiles.where("last_name LIKE ?", "%#{params[:last_name]}%") if params[:last_name].present?
    @profiles = @profiles.where("age > ?", params[:age_low]) if params[:age_low].present?
    @profiles = @profiles.where("age < ?", params[:age_high]) if params[:age_high].present?
    @profiles = @profiles.where("location LIKE ?", "%#{params[:location]}%") if params[:location].present?
    #@profiles = @profiles.by_instrument(params[:instrument]) if params[:instrument].present?
    @profiles = @profiles.paginate(:page => params[:page], :per_page => 30) # TODO: test with and without this!
    # @profiles = @profiles.preload(:instrument) # TODO: test with and without this!
    render "home"
  end


  private

  def application_params
    params.require(:application).permit(:first_name, :last_name, :age_low, :age_high, :location, :instrument)
  end
  

end
