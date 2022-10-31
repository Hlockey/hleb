# frozen_string_literal: true

module StandingsHelper
  def render_divisions(divisions)
    render(partial: 'league/standings/divisions', locals: {
      divisions: ,
      link: divisions.length > 1
    })
  end
end
