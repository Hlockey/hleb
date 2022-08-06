# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @info = INFO
    @links = LINKS
  end
end
