class UserMailer < ActionMailer::Base
  default from: 'noreply@example.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: 'Пожалуйства, подтвердите регстрацию')
  end
end
