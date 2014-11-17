require_relative '../acceptance_helper'

feature 'View user profile', %q{
  In order to know more about q/a author
  user can view his profile

} do

  let!(:user) { create(:user, rating: 123) }
  

  scenario 'Visit user profile' do
    visit profile_path(user)
    expect(page).to have_content(user.name) 
    expect(page).to have_content(user.email) 
    expect(page).to have_content(user.rating) 
  end




  
end