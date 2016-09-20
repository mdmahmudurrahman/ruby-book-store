# frozen_string_literal: true
require 'rails_helper'

feature 'admin-panel' do
  before(:all) do
    @user = create :user
    @admin = create :admin

    @book = create :book
    @order = create :order
    @author = create :author
    @category = create :category
  end

  context 'admin' do
    background do
      login_as @admin, scope: :user
      visit admin_panel_path
    end

    feature 'authorization' do
      scenario 'access applied' do
        expect(page).not_to have_content 'Log in'
        expect(page).to have_content 'Site Administration'
      end
    end

    feature 'entity management' do
      feature 'book' do
        scenario '#create' do
          visit admin_panel.new_path model_name: 'book'

          within '#new_book' do
            fill_in 'Title', with: @book.title
            fill_in 'Price', with: @book.price
            fill_in 'Count', with: @book.count

            select @author.label, from: 'Authors'
            select @category.label, from: 'Categories'

            click_button 'Save'
          end

          expect(page).to have_content 'Book successfully created'
        end

        scenario '#update' do
          visit admin_panel.edit_path model_name: 'book', id: @book.id

          within '#edit_book' do
            select @author.label, from: 'Authors'
            select @category.label, from: 'Categories'

            click_button 'Save'
          end

          expect(page).to have_content 'Book successfully updated'
        end

        scenario '#delete' do
          visit admin_panel.delete_path model_name: 'book', id: @book.id
          within('.edit_book') { click_button "Yes, I'm sure" }
          expect(page).to have_content 'Book successfully deleted'
        end
      end

      feature 'author' do
        scenario '#create' do
          visit admin_panel.new_path model_name: 'author'

          within '#new_author' do
            fill_in 'Firstname', with: @author.firstname
            fill_in 'Lastname', with: @author.lastname
            click_button 'Save'
          end

          expect(page).to have_content 'Author successfully created'
        end

        scenario '#update' do
          visit admin_panel.edit_path model_name: 'author', id: @author.id

          within '#edit_author' do
            fill_in 'Firstname', with: 'Firstname'
            fill_in 'Lastname', with: 'Lastname'
            click_button 'Save'
          end

          expect(page).to have_content 'Author successfully updated'
        end

        scenario '#delete' do
          visit admin_panel.delete_path model_name: 'author', id: @author.id
          within('.edit_author') { click_button "Yes, I'm sure" }
          expect(page).to have_content 'Author successfully deleted'
        end
      end

      feature 'category' do
        scenario '#create' do
          visit admin_panel.new_path model_name: 'category'

          within '#new_category' do
            fill_in 'Name', with: (build :category).name
            click_button 'Save'
          end

          expect(page).to have_content 'Category successfully created'
        end

        scenario '#update' do
          visit admin_panel.edit_path model_name: 'category', id: @category.id

          within '#edit_category' do
            fill_in 'Name', with: (build :category).name
            click_button 'Save'
          end

          expect(page).to have_content 'Category successfully updated'
        end

        scenario '#delete' do
          visit admin_panel.delete_path model_name: 'category', id: @category.id
          within('.edit_category') { click_button "Yes, I'm sure" }
          expect(page).to have_content 'Category successfully deleted'
        end
      end

      feature 'order' do
        {
          canceled: ['CANCELED'],
          delivered: ['DELIVERED'],
          in_delivery: ['IN DELIVERY', 'DELIVERED'],
          in_progress: ['IN PROGRESS', 'IN QUEUE'],
          in_queue: ['IN QUEUE', 'IN DELIVERY', 'CANCELED']
        }.each do |key, states|
          states.each do |state|
            scenario "#update (#{key} => #{state})" do
              order = FactoryGirl.create "order_#{key}"
              visit admin_panel.edit_path model_name: 'order', id: order.id
              expect(page).to have_select('order_state', options: states + [''])
              select state, from: 'State'; click_button 'Save and edit'
              expect(page).to have_content 'Order successfully updated'
            end
          end
        end
      end
    end
  end

  context 'user' do
    background do
      login_as @user, scope: :user
      visit admin_panel_path
    end

    feature 'authorization' do
      scenario 'access denied' do
        message = I18n.t 'cancan.access_denied'
        expect(page).to have_content message
      end
    end
  end
end
