# frozen_string_literal: true

class ActiveSessionsController < ApplicationController
  before_action(:authenticate_friend)

  def destroy
    if params[:id] == 'all'
      current_friend.active_sessions.destroy_all
    else
      current_friend.active_sessions.find(params[:id]).destroy
    end

    if current_friend
      redirect_to(account_path, notice: 'session deleted')
    else
      forget_active_session
      reset_session
      redirect_to(root_path, notice: 'signed out')
    end
  end
end
