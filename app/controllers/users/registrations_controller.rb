# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    agreed = params[:agree]
    return delete if agreed
    redirect_to settings_path
  end

  private

  def delete
    resource.mark_as_deleted

    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?

    yield resource if block_given?

    respond_with_navigational(resource) do
      redirect_to after_sign_out_path_for resource_name
    end
  end
end
