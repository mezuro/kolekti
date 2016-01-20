require 'kolekti/version'
require 'kolekti/collector'
require 'kolekti/entities'
require 'kolekti/runner'
require 'kolekti/persistence_strategy'
require 'kolekti/errors'

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

  def self.default_metric_value(metric_configuration)
    metric = metric_configuration.metric

    collector = collectors.find { |coll| coll.name == metric.metric_collector_name }
    return nil if collector.nil?

    collector.default_value_from(metric_configuration)
  end
end
