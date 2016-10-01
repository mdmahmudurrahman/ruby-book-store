# frozen_string_literal: true
feature 'Store' do
  background do
    create_list(:hidden_book, 2).each do |book|
      create :order_item, book: book
    end

    create_list :order_item, 3
    create_list :book, 5
    visit root_path
  end

  scenario '#bestsellers' do
    expect(page).to have_css '.carousel-cell', count: 5
    items = OrderItem.joins(:book).merge Book.visible
    check_book_titles_presence items.map(&:book)
    check_book_titles_absence Book.hidden
  end

  %w(presence absence).each do |type|
    define_method "check_book_titles_#{type}" do |books|
      send "check_string_array_#{type}", books.map(&:title)
    end
  end

  def check_string_array_presence(strings)
    strings.each { |string| expect(page).to have_content string }
  end

  def check_string_array_absence(strings)
    strings.each { |string| expect(page).not_to have_content string }
  end
end
