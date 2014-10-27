class ConfirmMailerPreview < ActionMailer::Preview


  def confirmation_instructions
    ConfirmMailer.confirmation_instructions(User.first, '1234567891011121314', provider: "twitter")
    
  end


end