require 'spec_helper'

describe Kolekti::Runner do
  let(:repository_path) { 'test' }
  let(:wanted_metric_configurations) { [FactoryGirl.build(:metric_configuration)] }

  subject { described_class.new({ repository_path: repository_path, wanted_metric_configurations: wanted_metric_configurations }) }

  before :all do
    @collector = FactoryGirl.build(:collector)
    Kolekti.register_collector(@collector)
  end

  describe 'initialization' do
    it 'is expected set repository_path' do
      expect(subject.repository_path).to eq(repository_path)
    end

    it 'is expected set wanted_metric_configurations' do
      expect(subject.wanted_metric_configurations).to eq(wanted_metric_configurations)
    end

    it 'is expected to set the collectors list' do
      expect(subject.collectors).to eq([@collector])
    end
  end

  describe 'run_wanted_metrics' do
    it 'is expected to run for the metrics already associated' do
      @collector.expects(:collect_metrics).with(repository_path, wanted_metric_configurations)

      subject.run_wanted_metrics
    end
  end

  describe 'clean_output' do
    it 'is expected to clean the output files' do
      @collector.expects(:clean).with(repository_path, wanted_metric_configurations)

      subject.clean_output
    end
  end
end
