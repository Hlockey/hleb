# frozen_string_literal: true

require_relative('boot')
require('rails/all')
require('sprockets/railtie')

Bundler.require(*Rails.groups)

module Hleb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(7.0)

    # Prevent error in browser console
    config.action_view.preload_links_header = false

    # After Rails starts, make a thread to update the league
    # & send game messages to Turbo Streams
    config.after_initialize do
      include ActiveModel::Model # For Turbo::Broadcastable
      include Turbo::Broadcastable

      Thread.new do
        stream_idxs = Array.new($league.teams.length / 2) { 0 }

        loop do
          $league.update_state

          $league.games.each_with_index do |game, i|
            stream_idxs[i] = 0 if stream_idxs[i] > game.stream.length

            next unless stream_idxs[i] < game.stream.length

            game.stream[stream_idxs[i]..].each do |message|
              broadcast_append_to("game_#{i}",
                                  partial: 'league/games/message',
                                  locals: { message: message, scroll: true },
                                  target: 'messages')
            end

            stream_idxs[i] = game.stream.length
          end

          sleep(5)
        end
      end
    end
  end
end
