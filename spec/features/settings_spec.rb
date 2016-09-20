# frozen_string_literal: true
require 'rails_helper'

feature 'Settings' do
  let(:user) { create :user }
  let(:address) { create :address }

  background do
    login_as user, scope: :user
    visit settings_path
  end

  context '#address' do
    %i(billing shipping).each do |type|
      context "##{type} address" do
        scenario '#submit empty form' do
          within(".user-#{type}-address-form") { click_button 'Save' }
          expect(page).not_to have_content I18n.t "settings.index.#{type}_address"
        end

        scenario '#submit correct form' do
          %i(firstname lastname street city zipcode phone).each do |field|
            selector = "user_#{type}_address_attributes_#{field}"
            fill_in selector, with: address.send(field)
          end

          within(".user-#{type}-address-form") { click_button 'Save' }
          expect(page).to have_content I18n.t "settings.index.#{type}_address"
        end
      end
    end
  end

  context '#email' do
    scenario '#submit without editing' do
      within('.user-email-form') { click_button 'Update' }
      expect(page).not_to have_content I18n.t 'settings.index.email'
    end

    scenario '#submit with email that already exist' do
      fill_in 'user_email', with: create(:user).email
      within('.user-email-form') { click_button 'Update' }
      expect(page).not_to have_content I18n.t 'settings.index.email'
    end

    scenario '#submit with new email' do
      email = FFaker::Internet.email
      fill_in 'user_email', with: email
      within('.user-email-form') { click_button 'Update' }
      expect(page).to have_content I18n.t 'settings.index.email'
    end
  end

  context '#password' do
    scenario '#submit without editing' do
      within('.user-password-form') { click_button 'Update' }
      expect(page).not_to have_content I18n.t 'settings.index.password'
    end

    scenario '#submit with not all fields' do
      password = FFaker::Internet.password
      fill_in 'user_password', with: password
      fill_in 'user_current_password', with: user.password
      within('.user-password-form') { click_button 'Update' }
      expect(page).not_to have_content I18n.t 'settings.index.password'
    end

    scenario '#submit with new password' do
      password = FFaker::Internet.password
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      fill_in 'user_current_password', with: user.password
      within('.user-password-form') { click_button 'Update' }
      expect(page).to have_content I18n.t 'settings.index.password'
    end
  end

  context '#remove account' do
    scenario '#with agreement' do
      caption = I18n.t 'settings.form_user_destroy.destroy_button_caption'
      check 'agree'; within('.user-destroy-form') { click_button caption }
      expect(page).to have_content 'successfully cancelled'
    end

    scenario '#without agreement' do
      caption = I18n.t 'settings.form_user_destroy.destroy_button_caption'
      within('.user-destroy-form') { click_button caption }
      expect(page).not_to have_content 'cancelled'
    end
  end
end
