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

    UserMailer.contact_form(@email, @name, @message).deliver_later
  end
end
