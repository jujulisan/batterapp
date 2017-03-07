class Site::SearchController < SiteController

  def ads
    @ads = Ad.where(title: params[:q])
  end

end
