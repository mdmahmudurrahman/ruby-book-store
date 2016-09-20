# frozen_string_literal: true
module SettingsHelper
  def form_options
    { url: settings_path }
  end

  def address_form_options
    form_options
  end

  %w(email password).each do |type|
    define_method "#{type}_form_options" do
      form_options.merge html: { autocomplete: 'off' }
    end

    define_method "#{type}_field_options" do
      { label: false, required: true }
    end
  end

  def destroy_user_form_options
    { method: :delete,
      url: user_registration_path,
      html: { class: 'form-horizontal clearfix' } }
  end

  def destroy_button_options
    { class: 'user-destroy-button btn-danger' }
  end
end
