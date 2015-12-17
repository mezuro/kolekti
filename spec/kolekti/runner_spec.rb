
require 'spec_helper'

describe Kolekti::Runner do
  let(:repository_path) { 'test' }
  let(:persistence_strategy) { Kolekti::TestPersistenceStrategy.new }
  let(:wanted_metric_configurations) {
    [
      FactoryGirl.build(:metric_configuration),
      FactoryGirl.build(:other_metric_configuration)
    ]
  }
  let(:wanted_metric_configurations_hash) { wanted_metric_configurations.map { |mc| [mc.metric.code, mc] }.to_h }
  let(:collectors) {
    wanted_metric_configurations.map do |mc|
      FactoryGirl.build(:collector, supported_metrics: { mc.metric.code => mc.metric })
    end
  }

  subject { described_class.new(repository_path, wanted_metric_configurations, persistence_strategy) }

  before :each do
    collectors.each do |collector|
      Kolekti.register_collector(collector)
    end
  end

  after :each do
    collectors.each do |collector|
      Kolekti.unregister_collector(collector)
    end
  end

  describe 'initialization' do
    it 'is expected set repository_path' do
      expect(subject.repository_path).to eq(repository_path)
    end

    it 'is expected set wanted_metric_configurations' do
      expect(subject.wanted_metric_configurations).to eq(wanted_metric_configurations_hash)
    end

    it 'is expected to set the collectors list' do
      expect(subject.collectors).to eq(collectors)
    end
  end

  describe 'run_wanted_metrics' do
    it 'is expected to run for the metrics already associated' do
      collectors.each do |collector|
        collector.expects(:collect_metrics).with(repository_path, wanted_metric_configurations_hash, persistence_strategy)
      end

      subject.run_wanted_metrics
    end
  end

  describe 'clean_output' do
    it 'is expected to clean the output files' do
      collectors.each do |collector|
        collector.expects(:clean).with(repository_path, wanted_metric_configurations_hash)
      end

      subject.clean_output
    end
  end
end
