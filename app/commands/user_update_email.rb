# frozen_string_literal: true
class UserUpdateEmail < Rectify::Command
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.assign_attributes @params

    status = if !@user.changed?
               :downtime
             elsif @user.valid? && @user.save
               :success
             else
               :failure
             end

    broadcast status
  end
end
