# frozen_string_literal: true
class SettingsController < ApplicationController
  authorize_resource class: false

  before_action :initialize_user,
                :initialize_params

  decorates_assigned :user

  def index
    params[:operation].tap do |operation|
      send "update_#{operation}" if operation
    end
  end

  private

  def update_email
    UserUpdateEmail.call @user, @params do
      on(:success) { redirect_to settings_path, alert: :email }
      on(:downtime) { redirect_to settings_path }
    end
  end

  def update_password
    UserUpdatePassword.call @user, @params do
      on(:success) do
        bypass_sign_in @user
        flash[:alert] = :password
        redirect_to settings_path
      end
    end

    %i(password password_confirmation).each do |field|
      @user.errors.add field, :blank if @params[field].blank?
    end
  end

  def update_address
    UserUpdateAddress.call @user, @type, @params do
      on(:success) do
        type = params.dig :address, :type
        flash[:alert] = "#{type}_address"
        redirect_to settings_path
      end

      on(:downtime) { redirect_to settings_path }
    end
  end

  def initialize_user
    @user = current_user
  end

  def initialize_params
    params[:operation].tap do |operation|
      send "#{operation}_params" if operation
    end
  end

  def email_params
    @params = params.require(:user).permit :email
  end

  def password_params
    @params = params.require(:user).permit :password,
                                           :current_password,
                                           :password_confirmation
  end

  def address_params
    @type = type = params.dig :address, :type
    attributes = %i(id lastname firstname street city zipcode phone country)
    @params = params.require(:user).permit "#{type}_address_attributes": attributes
  end
end
