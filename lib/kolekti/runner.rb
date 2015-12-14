require 'kolekti/errors'

module Kolekti
  class Runner
    attr_reader :repository_path, :wanted_metric_configurations, :collectors

    def initialize(repository_path, wanted_metric_configurations, persistence_strategy)
      @repository_path = repository_path
      @wanted_metric_configurations = wanted_metric_configurations.map { |m| [m.metric.code, m] }.to_h
      @persistence_strategy = persistence_strategy
      @collectors = find_collectors
    end

    def run_wanted_metrics
      @collectors.each do |collector|
        collector.collect_metrics(@repository_path, @wanted_metric_configurations, @persistence_strategy)
      end
    end

    def clean_output
      @collectors.each do |collector|
        collector.clean(@repository_path, @wanted_metric_configurations)
      end
    end

    private

    def find_collectors
      collectors = wanted_metric_configurations.map do |code, metric_configuration|
        found_collector = Kolekti.collectors.find { |collector| collector.supported_metrics.include? code }
        raise UnavailbleMetricError.new("No Metric Collector for metric code #{code}") if found_collector.nil?

        found_collector
      end

      collectors.uniq
    end
  end
end
