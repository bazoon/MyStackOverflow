require "rails_helper"

RSpec.describe QuestionAuthorMailer, type: :mailer do
  describe 'notify' do
    let(:user) { create(:user) }
    let(:answer) { create(:answer) }
    let(:mail) { QuestionAuthorMailer.notify(user, answer) }

    it 'renders the subject' do
      expect(mail.subject).to eql('You has new answers')
    end

    it 'Send an email' do
      QuestionAuthorMailer.notify(user, answer).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the reciever email' do
      expect(mail.to).to eql([user.email])
    end

    it 'assigns email' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
