class DigestMailer < Devise::Mailer   
  default from: 'foo@mailinator.com'


  def every_day_questions(email, questions)
    @questions = questions
    mail(to: email, subject: 'Everyday Digest')
  end
  
end