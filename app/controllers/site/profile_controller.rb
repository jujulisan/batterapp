class Site::ProfileController < SiteController
  before_action :authenticate_member!
  layout 'profile'
end
