class Users::SessionsController < Devise::SessionsController
  before_action :user_is_active?, only: [:create]  

  def user_is_active?
    unless params[:user][:email].empty? || params[:user][:password].empty?
      unless User.find_by(email: params[:user][:email]).try(:is_active)
        flash[:alert] = I18n.t :is_not_activated, scope: [:app, :users]
        redirect_to user_session_path
      end
    end
  end

end
