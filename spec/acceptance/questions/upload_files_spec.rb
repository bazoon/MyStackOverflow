require_relative '../acceptance_helper'

feature 'Add files to a question', %q{
  In order to iilustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question', js: true do
    fill_in t('questions.title'), with: 'Test question'
    fill_in t('questions.body'), with: 'text text text'
    click_on "Add an attachment"
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on t('save')

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end