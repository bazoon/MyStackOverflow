require 'rails_helper'
require "sidekiq_helper"

RSpec.describe DigestWorker  do
  
  let(:user) { create(:user) } 

  it 'calls User.find_each', sidekiq: :inline do
    expect(User).to receive(:find_each)
    DigestWorker.perform_async
  end

  it 'calls UserDigestWorker.perform_async', sidekiq: :inline do
    user
    expect(UserDigestWorker).to receive(:perform_async)
    DigestWorker.perform_async
  end  

  it 'Pushes 1 job for DigestWorker', sidekiq: :fake do
    expect { DigestWorker.perform_async }.to change(DigestWorker.jobs, :size).by(1)
  end

  
end