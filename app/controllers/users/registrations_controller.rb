# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: [:edit, :update, :destroy]

  def create
    build_resource(sign_up_params)

    if resource.save
      set_flash_message! :notice, :signed_up
      sign_in(resource_name, resource)
      redirect_to after_sign_up_path_for(resource), status: :see_other
    else
      clean_up_passwords resource
      set_minimum_password_length

      render :new, status: :unprocessable_entity, formats: [:html]
    end
  end

  private

  def ensure_normal_user
    if current_user&.guest?
      redirect_to root_path, alert: "ゲストユーザーはアカウント設定を更新できません。"
    end
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
