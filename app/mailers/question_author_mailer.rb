class QuestionAuthorMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_author_mailer.notify.subject
  #
  def notify(user, answer)
    @user = user
    @answer =answer
    mail(to: user.email, subject: 'You has new answers')  
  end

end
