require 'rails_helper'

RSpec.describe ConfirmMailer, :type => :mailer do
  
  let(:user) { create(:user) } 
  let(:mail) { ConfirmMailer.confirmation_instructions(user, 'token1234', provider: 'twitter') }

  it 'renders the subject' do
    expect(mail.subject).to eql('Confirmation instructions')
  end

  it 'Send an email' do
    ConfirmMailer.confirmation_instructions(user, 'token', provider: 'twitter').deliver
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the reciever email' do
    expect(mail.to).to eql([user.email])
  end

  it 'assigns @name' do
    expect(mail.body.encoded).to match(user.email)
  end

  it 'renders confirmation token' do
    expect(mail.body.encoded).to match('token1234')
  end

end
