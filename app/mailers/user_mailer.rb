class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail(to: @user.email, subject: 'アカウント登録のお知らせ')
  end

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'パスワードの再設定のお願い')
  end
end
