class OrderMailer < ApplicationMailer
  def order_email
    @user = params[:user]
    @order = params[:order]
    @url = "http://localhost:3000/orders/#{@order.id}"
    mail(to: @user.email, subject: "Order Confirmation: The Jungle (Order # #{@order.id})")
  end
end
