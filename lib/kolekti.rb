require 'kolekti/version'
require 'kolekti/runner'

module Kolekti
  COLLECTORS = []

  def self.register_collector(collector)
    COLLECTORS << collector
  end
end

