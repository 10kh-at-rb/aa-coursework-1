class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activation_email(user)
    @user = user
    @url  = 'http://localhost:3000/users/activate?activation_token='
    @url += "#{user.activation_token}"
    mail(to: user.email, subject: 'Please activate your account!')
  end
end
