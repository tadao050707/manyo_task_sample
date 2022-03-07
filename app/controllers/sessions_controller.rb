class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to tasks_path, notice: t('common.require_logout') if current_user
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: t('.logged_in')
    else
      flash.now[:notice] = t('.email_or_password_wrong')
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: t('.logged_out')
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
