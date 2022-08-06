# frozen_string_literal: true

class Friend < ApplicationRecord
  include TeamValidation

  has_secure_password
  has_many(:active_sessions, dependent: :destroy)
  validates(:username, presence: true, uniqueness: true)
  attribute(:votes, :integer, default: 3)

  # Delete this method once updated to Rails 7.1 - it will be provided by Rails
  # This is copy-pasted from Rails 7.1 source code
  def self.authenticate_by(attributes)
    passwords, identifiers = attributes.to_h.partition do |name, _value|
      !has_attribute?(name) && has_attribute?("#{name}_digest")
    end.map(&:to_h)

    raise ArgumentError, 'One or more password arguments are required' if passwords.empty?
    raise ArgumentError, 'One or more finder arguments are required' if identifiers.empty?

    return if passwords.any? { |_name, value| value.nil? || value.empty? }

    if record = find_by(identifiers)
      record if passwords.count { |name, value| record.public_send(:"authenticate_#{name}", value) } == passwords.size
    else
      new(passwords)
      nil
    end
  end
end
