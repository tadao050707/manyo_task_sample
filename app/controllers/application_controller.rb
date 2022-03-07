class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user

  def admin_required
    redirect_to tasks_path, notice: t('common.admin_required') unless current_user.admin?
  end

  private

  def require_login
    unless current_user
      flash[:notice] = t('common.require_login')
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
