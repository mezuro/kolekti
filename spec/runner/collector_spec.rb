require 'spec_helper'

class RunnerDouble < Kolekti::Runner::Base
  def self.metric_codes
    [:test]
  end
end

describe Kolekti::Runner::Collector do
  describe 'initialization' do
    let(:repository_path) { 'test' }
    let(:wanted_metric_configurations) { [] }

    subject { described_class.new({ repository_path: repository_path, wanted_metric_configurations: wanted_metric_configurations }) }

    it 'is expected set repository_path' do
      expect(subject.repository_path).to eq(repository_path)
    end

    it 'is expected set wanted_metric_configurations' do
      expect(subject.wanted_metric_configurations).to eq(wanted_metric_configurations)
    end

    it 'is expected to set the runners list' do
      expect(subject.runners).to eq({ test: RunnerDouble })
    end
  end
end
