# frozen_string_literal: true
class UserUpdatePassword < Rectify::Command
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    broadcast :success if @user.update_with_password @params
  end
end
