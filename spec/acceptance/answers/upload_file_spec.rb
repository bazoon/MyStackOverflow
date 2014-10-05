require_relative '../acceptance_helper'

feature 'Add files to an answer', %q{
  In order to iilustrate my answer
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when answer a question', js: true do
    fill_in t('answers.body'), with: 'text text text'
    
    within('.new-answer') do
      click_on 'Add an attachment'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on t('save')
    end

    within('.answers') do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end