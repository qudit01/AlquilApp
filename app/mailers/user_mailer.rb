class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user
    @url  = edit_reset_password_url(@user.reset_password_token)
    mail(to: user.email,
         subject: 'Solicitud de cambio de contraseña')
  end

  def accepted_license_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Noticas sobre el estado de tu licencia')
  end
end
