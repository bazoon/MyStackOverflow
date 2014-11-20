class QuestionSubscriptionMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify(user, question)
    @user = user
    @question = question

    mail to: user.email, subject: 'Question has new answers'
  end
end
