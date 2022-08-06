# frozen_string_literal: true

class Vote < ApplicationRecord
  include TeamValidation

  validates(:category, presence: true, numericality: {
              in: 0...ELECTION.length,
              only_integer: true
            })
  validate(:option_correct)

  private

  def option_correct
    unless option.integer? && option >= 0 && option < ELECTION.values[category].length
      errors.add(:option, 'must be a real option')
    end
  end

  def extra_info_correct; end
end
