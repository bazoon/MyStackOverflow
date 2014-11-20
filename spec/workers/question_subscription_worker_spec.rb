require 'rails_helper'
require "sidekiq_helper"

RSpec.describe QuestionSubscriptionWorker  do
  
  let!(:user) { create(:user) } 
  let!(:question) { create(:question)} 

  it 'calls QuestionSubscriptionMailer.notify', sidekiq: :inline do
    mailer = instance_double('QuestionSubscriptionMailer')
    allow(mailer).to receive(:deliver)
    allow(QuestionSubscriptionMailer).to receive(:notify) { mailer }
    
    # expect(mailer).to receive(:deliver)
    expect(QuestionSubscriptionMailer).to receive(:notify).with(user, question)
    QuestionSubscriptionWorker.perform_async(user.id, question.id)
  end


  it 'Pushes 1 job for QuestionSubscriptionWorker', sidekiq: :fake do
    expect { QuestionSubscriptionWorker.perform_async }.to change(QuestionSubscriptionWorker.jobs, :size).by(1)
  end

  
end