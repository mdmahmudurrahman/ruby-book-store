# frozen_string_literal: true
require 'rails_helper'

feature Author do
  let(:author) { create :author_with_books }

  background do
    visit author_path id: author.id
  end

  scenario '#information' do
    %i(label description).each do |method|
      expect(page).to have_content author.send method
    end
  end

  scenario '#books' do
    author.books.visible.page(1).each do |book|
      expect(page).to have_content book.title
    end
  end
end
