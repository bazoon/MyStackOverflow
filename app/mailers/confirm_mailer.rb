class ConfirmMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`


  def confirmation_instructions(record, token, options = {})
    @provider = options[:provider].capitalize if options[:provider]
    super
  end

end