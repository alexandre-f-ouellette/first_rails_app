class StaticPagesController < ApplicationController
  def index
  end

  def landing_page
    @products = Product.limit(3).order('id desc')
  end
end
