class Site::CategoriesController < SiteController

  def show
    @category   = Category.friendly.find(params[:id])
    @ads        = Ad.by_category(@category)
  end
end
