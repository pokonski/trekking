class ApplicationController < ActionController::Base
  protect_from_forgery


  def index
    @routes = Route.order_by([:created_at,:desc]).limit(10).all
  end
end
