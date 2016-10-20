module ControllerHelpers

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = users(:one)
      profile = profiles(:one)
      user.profile = profile
      sign_in user
    end
  end

end
