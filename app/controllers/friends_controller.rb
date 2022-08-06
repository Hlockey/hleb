# frozen_string_literal: true

class FriendsController < ApplicationController
  before_action(:redirect_if_authenticated, only: %i[create new])
  before_action(:authenticate_friend, only: %i[edit destroy])
  before_action(:sha256_password, only: [:create])

  def new
    @friend = Friend.new
    @teams = $league.teams
  end

  def create
    @friend = Friend.new(create_friend_params)
    @teams = $league.teams
    if @friend.save
      redirect_to(sign_in_path, notice: 'account created. sign in here')
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    Current.friend.destroy
    reset_session
    redirect_to(root_path, notice: 'your account no longer exists')
  end

  def edit
    set_edit_vars
  end

  def update
    set_edit_vars
    if Current.friend.update(update_friend_params)
      redirect_to(root_path, notice: 'your account has been updated')
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def set_edit_vars
    @teams = $league.teams
    @active_sessions = Current.friend.active_sessions.order(created_at: :desc)
  end

  def create_friend_params
    params.require(:friend).permit(:username, :password, :password_confirmation, :team)
  end

  def update_friend_params
    params.require(:friend).permit(:username, :team)
  end
end
