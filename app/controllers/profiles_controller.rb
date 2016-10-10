class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile, only: [:show, :edit, :update, :destroy]
    
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




    private
    
    def set_profile
        if params[:id] !=  nil
            @profile = Profile.find_by user_id: params[:id]
        else
            @profile = Profile.find_by user_id: current_user.id
        end
    end

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :age, :bio)
    end
    
end