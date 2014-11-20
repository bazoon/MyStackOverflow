require 'rails_helper'

RSpec.describe SubscriptionsController, :type => :controller do

  context 'Authorized' do
    sign_in_user


    describe 'PATCH subscribe' do

      let!(:user) { create(:user) }
      let!(:question) { create(:question) }
      let(:question_subscription) { create(:question_subscription, user: @user, question: question) }


      it 'calls for toggle_subscription ' do
        allow(QuestionSubscription).to receive(:toggle_subscription)
        expect(QuestionSubscription).to receive(:toggle_subscription)
        patch 'subscribe', question_id: question, format: :js
      end

      it 'creates new subscription if no exists' do
        expect { patch 'subscribe', question_id: question, format: :js }
        .to change(@user.question_subscriptions, :count).by(1)
      end

      it 'destroy subscription if it exists' do
        question_subscription
        expect { patch 'subscribe', question_id: question, format: :js }
        .to change(@user.question_subscriptions, :count).by(-1)
      end




    end





  end

  

end
