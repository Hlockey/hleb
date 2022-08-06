# frozen_string_literal: true

module TeamValidation
  extend ActiveSupport::Concern

  included do
    validates(:team, presence: true, numericality: {
                in: 0...$league.teams.length,
                only_integer: true
              })
  end
end
