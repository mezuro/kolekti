module Kolekti
  class PersistenceStrategy
    def create_tree_metric_result(module_name, metric_configuration, value, granularity)
      raise NotImplementedError
    end

    def create_hotspot_metric_result(module_name, metric_configuration, line, message)
      raise NotImplementedError
    end
  end

  class TestPersistenceStrategy < PersistenceStrategy
    def create_tree_metric_result(module_name, metric_configuration, value, granularity)
      puts "Create tree metric result: #{module_name} #{metric_configuration} #{value} #{granularity}"
    end

    def create_hotspot_metric_result(module_name, metric_configuration, line, message)
      puts "Create hotspot metric result: #{module_name} #{metric_configuration} #{line} #{message}"
    end
  end
end
