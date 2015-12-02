require 'spec_helper'

class RunnerDouble < Kolekti::Runner::Base
  def self.metric_codes
    [FactoryGirl.build(:metric).code.to_sym]
  end
end

describe Kolekti::Runner::Collector do
  let(:repository_path) { 'test' }
  let(:wanted_metric_configurations) { [FactoryGirl.build(:metric_configuration)] }

  subject { described_class.new({ repository_path: repository_path, wanted_metric_configurations: wanted_metric_configurations }) }

  describe 'initialization' do
    it 'is expected set repository_path' do
      expect(subject.repository_path).to eq(repository_path)
    end

    it 'is expected set wanted_metric_configurations' do
      expect(subject.wanted_metric_configurations).to eq(wanted_metric_configurations)
    end

    it 'is expected to set the runners list' do
      expect(subject.runners).to eq({ FactoryGirl.build(:metric).code.to_sym => RunnerDouble })
    end
  end

  describe 'run_wanted_metrics' do
    it 'is expected to run for the metrics already associated' do
      RunnerDouble.expects(:run).with(repository_path)

      subject.run_wanted_metrics
    end
  end

  describe 'clean_output' do
    it 'is expected to clean the output files' do
      RunnerDouble.expects(:clear).with(repository_path)

      subject.clean_output
    end
  end
end
