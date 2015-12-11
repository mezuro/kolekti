require 'kolekti/errors'

module Kolekti
  class Runner
    attr_reader :repository_path, :wanted_metric_configurations, :collectors

    def initialize(attributes={})
      @repository_path = attributes[:repository_path]
      @wanted_metric_configurations = attributes[:wanted_metric_configurations]
      @collectors = find_collectors
    end

    def run_wanted_metrics
      @collectors.each do |collector|
        collector.collect_metrics(@repository_path, @wanted_metric_configurations)
      end
    end

    def clean_output
      @collectors.each do |collector|
        collector.clean(@repository_path, @wanted_metric_configurations)
      end
    end

    private

    def find_collectors
      collectors = self.wanted_metric_configurations.map do |metric_configuration|
        code = metric_configuration.metric.code
        collector = Kolekti.collectors.find { |collector| collector.supported_metrics.include? code }
        raise UnavailbleMetricError.new("No Metric Collector for metric code #{code}") if collector.nil?

        collector
      end

      collectors.uniq
    end
  end
end
