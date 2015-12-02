module Kolekti
  module Runner
    class Collector
      attr_reader :repository_path, :wanted_metric_configurations, :runners

      def initialize(attributes={})
        @repository_path = attributes[:repository_path]
        @wanted_metric_configurations = attributes[:wanted_metric_configurations]
        @runners = {}
        Runner::IMPLEMENTED.each do |implemented|
          implemented.metric_codes.each { |metric_code| @runners[metric_code.to_sym] = implemented }
        end
      end

      def run_wanted_metrics
        self.wanted_metric_configurations.each do |metric_configuration|
          code = metric_configuration.metric.code.to_sym
          @runners[code].run(self.repository_path)
        end
      end

      def clean_output; end
    end
  end
end
