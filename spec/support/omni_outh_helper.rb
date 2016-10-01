# frozen_string_literal: true
module OmniAuthHelper
  def configure_omniauth
    mock_auth
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth']  = OmniAuth.config.mock_auth[:facebook]
  end

  def mock_auth
    info = {
      name:  FFaker::Address.name,
      email: FFaker::Internet.email
    }

    OmniAuth.config.test_mode            = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new \
      provider: 'facebook', uid: '123545', info: info
  end
end

RSpec.configure do |config|
  config.include OmniAuthHelper
end
