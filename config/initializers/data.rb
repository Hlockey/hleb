# frozen_string_literal: true

ELECTION = Hlockey.load_data('election').freeze
INFO = Hlockey.load_data('information').transform_values do |str|
  str.gsub("\n", '<br />')
end.freeze
LINKS = Hlockey.load_data('links').freeze
