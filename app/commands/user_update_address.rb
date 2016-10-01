# frozen_string_literal: true
class UserUpdateAddress < Rectify::Command
  def initialize(user, type, params)
    @user = user
    @type = type
    @params = params
  end

  def call
    @user.assign_attributes @params

    field = "#{@type}_address"
    address = @user.send field

    status = if !address.try :changed?
               :downtime
             elsif @user.valid? && @user.save
               :success
             else
               :failure
             end

    broadcast status
  end
end
