# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  def check_valid_id(item, item_amt, redir_path)
    id = begin
      Integer(params[:id])
    rescue StandardError
      -1
    end

    if id.negative? || id >= item_amt
      redirect_to(redir_path, alert: "no #{item} with id #{params[:id]}")
      return -1
    end

    id
  end
end
