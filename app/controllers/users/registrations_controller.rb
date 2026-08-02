# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: %i[edit update destroy]

    private

    def ensure_normal_user
      return unless current_user&.guest?

      redirect_to root_path, alert: 'ゲストユーザーはアカウント設定を更新できません。'
    end
  end
end
