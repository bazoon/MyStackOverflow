require_relative '../acceptance_helper'

feature 'Subscribe to question', %q{
  In order to get new answers notifications
  As an authenticated user
  I want to be able to subscribe to question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user subscribes to question', js: true do
    sign_in(user)

    visit question_path(question)
    expect(page).to have_link('subscribe')
    click_on 'subscribe'
    expect(page).to have_link('unsubscribe')

    
  end

  
end