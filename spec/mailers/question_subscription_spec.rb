require "rails_helper"

RSpec.describe QuestionSubscriptionMailer, :type => :mailer do
  describe "notify" do

    let(:user) { create(:user) }
    let(:question) { create(:question) }

    let(:mail) { QuestionSubscriptionMailer.notify(user, question) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Question has new answers')
    end

    it 'Send an email' do
      QuestionSubscriptionMailer.notify(user, question).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the reciever email' do
      expect(mail.to).to eql([user.email])
    end

    it 'assigns name' do
      expect(mail.body.encoded).to match(user.name)
    end







  end

end
