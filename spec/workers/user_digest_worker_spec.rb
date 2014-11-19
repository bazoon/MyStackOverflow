require 'rails_helper'
require "sidekiq_helper"

RSpec.describe UserDigestWorker  do
  
  let!(:user) { create(:user) } 
  let!(:questions) { create_list(:question, 2) } 

  it 'calls DigestMailer.every_day_questions', sidekiq: :inline do
    mailer = instance_double('EverydayDayMailer')
    allow(mailer).to receive(:deliver)
    allow(DigestMailer).to receive(:every_day_questions) { mailer }
    
    expect(DigestMailer).to receive(:every_day_questions)
    UserDigestWorker.perform_async(user.email)
  end


  it 'Pushes 1 job for UserDigestWorker', sidekiq: :fake do
    expect { UserDigestWorker.perform_async }.to change(UserDigestWorker.jobs, :size).by(1)
  end

  
end