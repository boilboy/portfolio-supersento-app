# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)

    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?

      redirect_to after_sign_in_path_for(resource), status: :see_other
    else
      flash.now[:alert] = I18n.t('devise.failure.invalid')

      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)

      render :new, status: :unprocessable_entity, formats: [:html]
    end
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
