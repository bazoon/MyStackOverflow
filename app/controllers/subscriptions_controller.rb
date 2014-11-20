class SubscriptionsController < ApplicationController

  respond_to :js

  def subscribe
    question = Question.find(params[:question_id])
    authorize question
    QuestionSubscription.toggle_subscription(question, current_user)
  end

end
