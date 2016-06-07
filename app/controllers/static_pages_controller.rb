class StaticPagesController < ApplicationController
  def index
  end

  def landing_page
    @products = Product.limit(3).order('id desc')
  end

  def about
    @products = Product.limit(3).order('id desc')
  end

  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    ActionMailer::Base.mail(
      :from => @email,
      :to => 'alexandre.f.ouellette@gmail.com',
      :subject => "A new contact message from #{@name}",
      :body => @message).deliver_later
  end
end
