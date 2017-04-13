class Site::HomeController < SiteController
  def index
    @categories = Category.order_by_description
    @ads = Ad.descending_order(params[:page])
    @carousel = Ad.limit(3).order("RANDOM()")
  end
end
