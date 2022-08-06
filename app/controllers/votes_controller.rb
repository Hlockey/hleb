# frozen_string_literal: true

class VotesController < ApplicationController
  before_action(:authenticate_friend, only: [:create])

  def index; end

  def create
    if Current.friend.votes.zero?
      redirect_to(votes_path, notice: 'you have no more votes')
      return
    end

    if Vote.new(vote_params).save
      Current.friend.decrement!(:votes)
      redirect_to(votes_path, notice: 'vote successful')
    else
      render(:index, status: :unprocessable_entity)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:category, :option, :team)
  end
end
