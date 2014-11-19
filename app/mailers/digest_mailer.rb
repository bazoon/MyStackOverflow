class DigestMailer < Devise::Mailer   
  default from: 'foo@mailinator.com'

  def every_day_questions(user, questions)
    @questions = questions
    mail(to: user.email, subject: 'Everyday Digest')
  end
  
end