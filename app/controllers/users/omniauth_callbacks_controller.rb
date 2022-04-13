# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def keyrock # メソッド名はstrategyで指定した名前
    p "-----call back------"
    p request.env['omniauth.auth']
    @user = User.find_or_create_with_keyrock(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(@user)
      set_flash_message(:notice, :success, kind: 'keyrock') if is_navigational_format?
      redirect_to root_url
    else
      session['devise.keyrock_data'] = request.env['omniauth.auth']
      redirect_to root_url, alert: 'Keyrock ログインに失敗しました'
    end
  end
end
