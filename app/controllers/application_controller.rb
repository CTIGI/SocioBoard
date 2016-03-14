class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  after_action :verify_authorized, :except => :index, unless: :devise_controller?
  after_action :verify_policy_scoped, :only => :index

  protect_from_forgery with: :exception

  layout :layout_by_resource

  def after_sign_in_path_for(*)
    dashboard_index_path
  end

  protected

  def layout_by_resource
    if current_user.blank?
      "unlloged"
    else
      "application"
    end
  end

  private

  def permission_denied
    head 403
  end

end
