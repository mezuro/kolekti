require 'kolekti/version'
require 'kolekti/collector'
require 'kolekti/entities'
require 'kolekti/runner'
require 'kolekti/persistence_strategy'
require 'kolekti/errors'

require 'kolekti/analizo'

module Kolekti
  COLLECTORS = []

  def self.register_collector(collector)
    COLLECTORS << collector
  end

  def self.collectors
    COLLECTORS
  end

  def self.unregister_collector(collector)
    raise ArgumentError.new("Collector #{collector} was not registered!") unless COLLECTORS.include? collector
    COLLECTORS.delete collector
  end

  def self.available_collectors
    collectors.select(&:available?)
  end
end

