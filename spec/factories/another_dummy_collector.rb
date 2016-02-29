class AnotherDummyCollector < Kolekti::Collector
  def initialize
    mc = FactoryGirl.build(:other_metric_configuration)
    super('name', 'description', { mc.metric.code => mc.metric })
  end
end
