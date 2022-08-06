# frozen_string_literal: true

module League
  class StandingsController < League::BaseController
    def index
      @divisions = $league.divisions
      @playoff_teams = $league.playoff_teams
      @champion_team = $league.champion_team
    end

    def show
      id = check_valid_id('team', $league.teams.length, league_standings_path)
      @team = $league.teams[id] unless id == -1
    end
  end
end
