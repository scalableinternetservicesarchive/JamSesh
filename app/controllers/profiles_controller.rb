class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :addInstrument]
  
  def show
  end
  
  def edit
  end
  
  def update
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def addInstrument
    if params[:instrument] != nil && params[:profile] != nil && params[:proficiency] != nil
      @instrument_profile = InstrumentProfile.find_by(profile_id: params[:profile], instrument_id: params[:instrument])
      if @instrument_profile == nil
        InstrumentProfile.create(:instrument_id => params[:instrument], :profile_id => params[:profile], :proficiency => params[:proficiency])
      else
        @instrument_profile.proficiency = params[:proficiency]
        @instrument_profile.save
        # Update instrument_profile with entered proficiency
        # @instrument_profile.
      end
    end
  end



  private
  
  def set_profile
    if params[:id] !=  nil
      @profile = Profile.find_by user_id: params[:id]
    else
      @profile = Profile.find_by user_id: current_user.id
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :age, :bio, :phone, :location, instrument_ids: [])
  end
  
end