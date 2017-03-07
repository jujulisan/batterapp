class SiteController < ApplicationController
  layout 'site'

  before_action :categories

  def categories

    @categories = Category.order_by_description
  end
end
