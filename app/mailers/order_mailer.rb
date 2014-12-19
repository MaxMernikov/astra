class OrderMailer < ActionMailer::Base
  default from: "no-reply@astrastore.by"

  def order_create
    mail(
      to: 'maxmernikov@gmail.com',

      subject: "Создан заказ на astrastore.by"
    )
  end
end