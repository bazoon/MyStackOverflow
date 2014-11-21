require 'rails_helper'
require "sidekiq_helper"

RSpec.describe QuestionAuthorWorker  do
  
  let!(:user) { create(:user) }
  let!(:answer) { create(:answer) }

  it 'calls QuestionAuthorMailer.notify', sidekiq: :inline do
    # mailer = instance_double('QuestionAuthorMailer')
    # allow(mailer).to receive(:deliver)
    
    # allow(QuestionAuthorMailer).to receive(:notify) { mailer }
    # expect(QuestionAuthorMailer).to receive(:notify).with(user, answer)
    QuestionAuthorWorker.perform_async(user.id, answer.id)
  end


  it 'Pushes 1 job for QuestionAuthorWorker', sidekiq: :fake do
    expect { QuestionAuthorWorker.perform_async }.to change(QuestionAuthorWorker.jobs, :size).by(1)
  end

  
end