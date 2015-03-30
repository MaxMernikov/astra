class NotificationMailer < ActionMailer::Base
  default from: "no-reply@astrastore.by"

  def feedback_created
    mail(
      to: 'maxmernikov@gmail.com',


      subject: "Пользователь оставил свой отзыв на astrastore.by"
    )
  end

  def order_created
    mail(
      to: 'maxmernikov@gmail.com',

      subject: "Создан заказ на astrastore.by"
    )
  end
end
