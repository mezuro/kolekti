require 'kolekti/version'
require 'kolekti/collector'
require 'kolekti/runner'

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
end

