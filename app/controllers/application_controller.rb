class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActionController::RoutingError, :with => :error_render_method

  def error_render_method
    respond_to do |type|
      type.xml { render :template => "errors/error_404", :status => 404 }
      type.all  { render :nothing => true, :status => 404 }
    end
    true
  end
end
