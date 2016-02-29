require 'kolekti/version'
require 'kolekti/collector'
require 'kolekti/runner'
require 'kolekti/persistence_strategy'
require 'kolekti/memory_persistence_strategy'
require 'kolekti/errors'

module Kolekti
  COLLECTORS = []

  def self.register_collector(collector)
    COLLECTORS << collector.new
  end

  def self.collectors
    COLLECTORS
  end

  def self.unregister_collector(collector)
    to_be_deregistered_index = -1
    COLLECTORS.each_with_index do |kollector, index|
      (to_be_deregistered_index = index) and break if kollector.is_a?(collector)
    end
    raise ArgumentError.new("Collector #{collector} was not registered!") if to_be_deregistered_index == -1
    COLLECTORS.delete_at(to_be_deregistered_index)
  end

  def self.default_metric_value(metric_configuration)
    metric = metric_configuration.metric

    collector = collectors.find { |coll| coll.name == metric.metric_collector_name }
    return nil if collector.nil?

    collector.default_value_from(metric_configuration)
  end
end
