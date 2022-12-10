class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user
    @url  = edit_reset_password_url(@user.reset_password_token)
    mail(to: user.email,
         subject: 'Tu contraseña ha sido restablecida')
  end
end
