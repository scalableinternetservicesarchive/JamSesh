module ControllerHelpers

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user_with_profile)
      sign_in user
    end
  end

end
