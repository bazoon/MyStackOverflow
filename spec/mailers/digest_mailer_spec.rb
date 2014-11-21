require "rails_helper"

RSpec.describe DigestMailer, type: :mailer do
  describe 'notify' do
    let(:user) { create(:user) }
    let(:questions) { create_list(:question,2) }
    let(:mail) { DigestMailer.every_day_questions(user.email, questions) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Everyday Digest')
    end

    it 'Send an email' do
      DigestMailer.every_day_questions(user.email, questions).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'send email to user' do
      expect(mail.to).to eql([user.email])
    end

    it 'assigns questions titles' do
      expect(mail.body.encoded).to match(questions.first.title)
      expect(mail.body.encoded).to match(questions.last.title)
    end
  end
end
