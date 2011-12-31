class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user, :posts_per_page, :topics_per_page, :users_per_page
  
  rescue_from CanCan::AccessDenied do |e|
    redirect_to main_app.root_url, :alert => e.message
  end
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session.record if current_user_session
  end
  
  def posts_per_page
    (current_user && current_user.posts_per_page) || 15
  end
  
  def topics_per_page
    (current_user && current_user.topics_per_page) || 30
  end
  
  def users_per_page
    (current_user && current_user.users_per_page) || 30
  end
end
