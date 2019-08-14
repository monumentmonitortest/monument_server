module ControllerMacros
  def login_user
    before  do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      subject.sign_in user # was sign_in user
    end
  end  
end