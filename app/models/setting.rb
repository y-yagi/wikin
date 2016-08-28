class Setting < ApplicationRecord
  before_save :set_one_time_password_secret

  def set_one_time_password_secret
    if self.enable_one_time_password && self.one_time_password_secret.blank?
      self.one_time_password_secret = Rails.application.message_verifier(:one_time_password_secret).generate(ROTP::Base32.random_base32)
    end
  end

  def original_one_time_password_secret
    Rails.application.message_verifier(:one_time_password_secret).verify(one_time_password_secret)
  end
end
