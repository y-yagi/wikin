class Admin::SettingsController < ApplicationController
  before_action :set_setting , only: [:edit, :update]
  def edit
    @setting = Setting.first_or_create
  end

  def update
    @setting.update(setting_params)
    render :edit
  end

  private
    def set_setting
      @setting = Setting.first_or_create
    end

    def setting_params
      params.require(:setting).permit(:enable_one_time_password)
    end
end
