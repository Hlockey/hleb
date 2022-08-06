# frozen_string_literal: true

module ApplicationHelper
  def in_application_layout(&block)
    render(inline: capture(&block), layout: 'layouts/application')
  end

  def emoji_team(team)
    raw("#{emoji(team)} #{team}")
  end

  def team_emoji(team)
    raw("#{team} #{emoji(team)}")
  end

  private

  def emoji(team)
    Rails.root.join("app/assets/images/twemojis/#{team}.svg").read
  end
end
