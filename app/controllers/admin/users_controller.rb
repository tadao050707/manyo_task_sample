class Admin::UsersController < ApplicationController
  before_action :admin_required
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.includes(:tasks).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('.destroyed')
    else
      redirect_to admin_users_path, notice: t('.prevent_removing_admin')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
