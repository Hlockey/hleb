# frozen_string_literal: true

class ActiveSession < ApplicationRecord
  belongs_to(:friend)
  has_secure_token
end
