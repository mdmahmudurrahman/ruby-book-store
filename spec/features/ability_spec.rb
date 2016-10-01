# frozen_string_literal: true
shared_examples 'cannot access hidden book page' do
  let(:hidden_book) { create :hidden_book }

  it 'cannot access hidden book page' do
    visit book_path id: hidden_book.id
    check_access_denied_presence
  end
end

feature Ability do
  context '#guest' do
    include_examples 'cannot access hidden book page'

    it 'cannot access settings page' do
      visit settings_path
      check_access_denied_presence
    end
  end

  context '#user' do
    before { login_as create(:user), scope: :user }
    include_examples 'cannot access hidden book page'

    it 'cannot access settings page' do
      visit settings_path
      check_access_denied_absence
    end
  end

  def check_access_denied_presence
    message = I18n.t 'cancan.access_denied'
    expect(page).to have_content message
  end

  def check_access_denied_absence
    message = I18n.t 'cancan.access_denied'
    expect(page).not_to have_content message
  end
end
