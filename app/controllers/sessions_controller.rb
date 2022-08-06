# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action(:redirect_if_authenticated, only: %i[create new])
  before_action(:authenticate_friend, only: [:destroy])
  before_action(:sha256_password, only: [:create])

  def create
    @friend = Friend.authenticate_by(username: params[:friend][:username],
                                     password: params[:friend][:password])
    if @friend
      after_sign_in_path = session[:return_path] || root_path
      active_session = sign_in(@friend)
      remember(active_session) if params[:friend][:remember] == '1'
      redirect_to(after_sign_in_path, notice: 'signed in')
    else
      flash.now[:alert] = 'incorrect username or password'
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    sign_out
    redirect_to(root_path, notice: 'signed out')
  end

  def new; end
end
