class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    skip_authorization

    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)

    # Update info on every login
    @user.image = auth.extra.raw_info[:picture][:data][:url] # assuming the user model has an image
    @user.gender = auth.extra.raw_info[:gender]

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
