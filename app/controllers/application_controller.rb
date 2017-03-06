class ApplicationController < ActionController::Base

  # Pundit
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Layouts
  layout :layout_by_resource

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def layout_by_resource
  	if devise_controller? && resource_name == :admin
  		'backoffice_devise'
    elsif devise_controller? && resource_name == :member
      'site_devise'
  	else
  		'application'
  	end
  end
end
