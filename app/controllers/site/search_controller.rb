class Site::SearchController < SiteController

  def ads
    @ads = Ad.search(params[:q], params[:page])
  end

end
