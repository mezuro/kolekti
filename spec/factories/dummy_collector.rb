class DummyCollector < Kolekti::Collector
  def initialize
    mc = FactoryGirl.build(:metric_configuration)
    super('name', 'description', { mc.metric.code => mc.metric })
  end
end
