require 'yaml'
require 'kalibro_client'

module Kolekti
  class Collector
    attr_reader :name, :description, :supported_metrics

    def self.run_if_available(command)
      begin
        `#{command}`
      rescue SystemCallError
        nil
      end
    end

    def available?; raise NotImplementedError; end

    def initialize(name, description, supported_metrics)
      @name = name
      @description = description
      @supported_metrics = supported_metrics
    end

    def collect_metrics(code_directory, wanted_metric_configurations); raise NotImplementedError; end

    def clean(code_directory, wanted_metric_configurations); raise NotImplementedError; end

    def parse_supported_metrics(metrics_path, metric_collector_name, languages)
      supported_metrics = {}
      YAML.load_file(metrics_path)[:metrics].each do | key, value |
        if value[:type] == "NativeMetricSnapshot"
          supported_metrics[key] = KalibroClient::Entities::Miscellaneous::NativeMetric.new(value[:name], key, value[:scope], languages, metric_collector_name)
        else
          supported_metrics[key] = KalibroClient::Entities::Miscellaneous::HotspotMetric.new(value[:name], key, languages, metric_collector_name)
        end
      end
      supported_metrics
    end
  end
end
