# frozen_string_literal: true

module League
  class GamesController < League::BaseController
    def index
      @games = $league.games
    end

    def show
      @id = check_valid_id('game', $league.games.length, league_games_path)
      @game = $league.games[@id] unless @id == -1
    end
  end
end
