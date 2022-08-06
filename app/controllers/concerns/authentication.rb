# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action(:current_friend)
    helper_method(:current_friend)
  end

  def sign_in(friend)
    reset_session
    active_session = friend.active_sessions.create!
    session[:current_active_session_id] = active_session.id
    active_session
  end

  def sign_out
    forget_active_session
    active_session = ActiveSession.find_by(id: session[:current_active_session_id])
    reset_session
    active_session.destroy! if active_session.present?
  end

  def redirect_if_authenticated
    redirect_to(root_path, alert: 'youre already signed in') if Current.friend.present?
  end

  def authenticate_friend
    session[:return_to] = request.original_url if request.get? && request.local?
    redirect_to(sign_in_path, alert: 'please sign in') unless Current.friend.present?
  end

  def remember(active_session)
    cookies.permanent.encrypted[:token] = active_session.token
  end

  def forget_active_session
    cookies.delete(:token)
  end

  def sha256_password
    params[:friend][:password] = Digest::SHA256.hexdigest(params[:friend][:password])
    if params[:friend][:password_confirmation]
      params[:friend][:password_confirmation] = Digest::SHA256.hexdigest(
        params[:friend][:password_confirmation]
      )
    end
  end

  private

  def current_friend
    Current.friend = if session[:current_active_session_id].present?
                       ActiveSession.find_by(id: session[:current_active_session_id])
                     elsif cookies.permanent.encrypted[:token].present?
                       ActiveSession.find_by(token: cookies.permanent.encrypted[:token])
                     end
                       &.friend
  end
end
