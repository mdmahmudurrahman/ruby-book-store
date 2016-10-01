# frozen_string_literal: true
require 'rails_helper'

feature Category do
  let(:category) { create :category }

  background do
    20.times { create :book, categories: [category] }
    visit category_path id: category.id
  end

  scenario '#first page' do
    expect(page).to have_css '.breadcrumb', text: category.name

    category.books[0..11].each do |book|
      expect(page).to have_content book.title
      expect(page).to have_content book.price
    end
  end

  scenario '#last page' do
    click_on 'Last'

    category.books[12..-1].each do |book|
      expect(page).to have_content book.title
      expect(page).to have_content book.price
    end
  end
end
