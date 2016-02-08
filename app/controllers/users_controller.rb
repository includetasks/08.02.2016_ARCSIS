# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  first_name             :string           not null
#  last_name              :string           not null
#  phone                  :string
#  is_active              :boolean          default(TRUE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class UsersController < ApplicationController
  # Redirects to the NotFound page is the selected user is not exists (by params[:id])
  before_action :find_user, only: [:edit, :update, :destroy, :change_password]

  # GET /users
  def index
    @users = User.paginate(page: params[:page]).order(id: :desc)
  end

  # GET /users/:id/edit
  def edit
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/:id/change_password
  def change_password
  end

  # PUT   /uesrs/:id
  # PATCH /uesrs/:id
  def update
    @user.update(permitted_params)

    if @user.errors.empty?
      flash[:notice] = I18n.t :updated, scope: [:app, :users]
      redirect_to users_path
    else
      flash[:alert] = I18n.t :update_error, scope: [:app, :users]
      prev = Rails.application.routes.recognize_path(request.referrer)
      if prev[:controller] == 'users'
        render prev[:action]
      else
        redirect_to users_path
      end
    end
  end

  # POST /users
  def create
    @user = User.new(permitted_params)
    @user.save

    if @user.errors.empty?
      flash[:notice] = I18n.t :created, scope: [:app, :users]
      redirect_to users_path
    else
      flash[:alert] = I18n.t :create_error, scope: [:app, :users]
      render 'new'
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy.destroyed?
      flash[:notice] = I18n.t :destroyed, scope: [:app, :users]
    else
      flash[:alert] = I18n.t :destroy_error, scope: [:app, :users]
    end

    redirect_to users_path
  end

  private

  # Before-callback. Redirects to the NotFound page if
  # the selected user (by params[:id]) is not exists.
  def find_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to(controller: :errors, action: :not_found) 
    end
  end

  def permitted_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :password,
      is_active: Parameters.boolean
    )
  end
end
