class ApplicationMailer < ActionMailer::Base
  default from: 'admins@alquilapp.com'
  layout 'mailer'

  # ActionMailer::Base.smtp_settings = {
  #   address: 'smtp.gmail.com',
  #   domain: 'mail.google.com',
  #   port: 587,
  #   user_name: 'foo@gmail.com',
  #   password: '******',
  #   authentication: :plain,
  #   enable_starttls_auto: true
  # }
end
