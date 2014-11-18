require_relative '../sphinx_config.rb'

feature 'Search all', %q{
  In order to find something
  user can search

} do

  let!(:question) { create(:question, title: "FINDME", body: "FINDME") }
  let!(:other_question) { create(:question, title: "Other", body: "FINDME") }
  let!(:answer) { create(:answer, question: other_question, body: 'answer') }
  let!(:question_comment) { create(:comment, commentable: question, body: "question_comment") }
  let!(:user) { create(:user, name: "foo") } 

  scenario 'search for question' do
    ThinkingSphinx::Test.run do
      visit '/'
      fill_in 'search', with: 'FINDME'
      click_on 'Find'
    end
    expect(page).to have_content(question.title)
    expect(page).to have_content(other_question.title)
  end

  scenario 'search for answer' do
    ThinkingSphinx::Test.run do
      visit '/'
      fill_in 'search', with: 'answer'
      click_on 'Find'
    end
    expect(page).to have_content(answer.body)
  end

  scenario 'search for comment' do
    ThinkingSphinx::Test.run do
      visit '/'
      fill_in 'search', with: 'question_comment'
      click_on 'Find'
    end
    expect(page).to have_content(question_comment.body)
  end

  scenario 'search for user' do
    ThinkingSphinx::Test.run do
      visit '/'
      fill_in 'search', with: user.name
      click_on 'Find'
    end
    expect(page).to have_content(user.email)
    expect(find_link("User: #{user.email}")[:href]).to eq(profile_path(user.id))
  end





  
end