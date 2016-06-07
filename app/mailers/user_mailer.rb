class UserMailer < ApplicationMailer
  default from: "alexandre.f.ouellette@gmail.com"

  def contact_form(email, name, message)
    @message = message
    @name = name

    mail(:from => email,
      :to => "alexandre.f.ouellette@gmail.com",
      :subject => "A new contact from message from #{name}")
  end
end
