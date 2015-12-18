require 'kalibro_client'
require 'kolekti/collector'
require 'kolekti/errors'
require 'kolekti/analizo/parser'

module Kolekti
  module Analizo
    class Collector < Kolekti::Collector
      def initialize
        super('Analizo', 'description', load_analizo_supported_metrics)
      end

      def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        parser = Analizo::Parser.new(wanted_metric_configurations, persistence_strategy)
        parser.parse_all(run code_directory)
      end

      def available?
        system('analizo --version', [:out, :err] => '/dev/null') ? true : false
      end

      protected

      def load_analizo_supported_metrics
        supported_metrics = {}
        global = true
        metric_list.each_line do |line|
          if line.include?("-")
            code = line[/^[^ ]*/] # From the beginning of line to the first space
            name = line[/- .*$/].slice(2..-1) # After the "- " to the end of line
            scope = global ? :SOFTWARE : :CLASS
            supported_metrics[code] = KalibroClient::Entities::Miscellaneous::NativeMetric.new(
              name, code, scope, [:C, :CPP, :JAVA], "Analizo")
          elsif line.include?("Module Metrics:")
            global = false
          end
        end

        supported_metrics
      end

      def run(code_directory)
        results = `analizo metrics #{code_directory}`
        raise Kolekti::CollectorError.new("Analizo failed with exit status: #{$?.exitstatus}") unless $?.success?
        results
      end

      def metric_list
        list = `analizo metrics --list`
        raise Kolekti::CollectorError.new("Analizo failed with exit status: #{$?.exitstatus}") unless $?.success?
        list
      end
    end
  end
end
