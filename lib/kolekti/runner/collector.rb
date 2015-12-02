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

      def run_wanted_metrics; end
      def clean_output; end
    end
  end
end
