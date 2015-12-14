require 'spec_helper'
require 'kalibro_client'

describe Kolekti::Analizo::Collector do
  describe 'run_wanted_metrics' do
    let(:metric_configurations) { [FactoryGirl.build(:metric_configuration, metric: FactoryGirl.build(:metric, code: 'total_eloc', scope: KalibroClient::Entities::Miscellaneous::Granularity::SOFTWARE))] }
    let(:strategy) { Kolekti::TestPersistenceStrategy.new }
    subject { described_class.new }
    let(:runner) { Kolekti::Runner.new('/home/marcheing/mezuro/sbking', metric_configurations, strategy) }

    it 'is expected to run the wanted metrics' do
      Kolekti.register_collector(subject)
      runner.run_wanted_metrics
    end
  end
end
