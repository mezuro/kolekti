require 'kalibro_client'
require 'kolekti/collector'
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
        `analizo --version`.nil? ? false : true
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

      private

      def run(code_directory)
        results = `analizo metrics #{code_directory}`
        raise Errors::NotFoundError.new("BaseTool Analizo not found") if results.nil?
        raise Errors::NotReadableError.new("Directory not readable") if results.empty?
        results
      end

      def metric_list
        list = `analizo metrics --list`
        raise Errors::NotFoundError.new("BaseTool Analizo not found") if list.nil?
        list
      end
    end
  end
end
