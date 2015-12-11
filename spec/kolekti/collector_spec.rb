require 'spec_helper'

describe Kolekti::Collector do
  subject { described_class.new("", "", []) }
  describe 'method' do
    describe 'run_if_available' do
      let(:command) { 'ls' }
      let(:command_out) { '.' }

      context 'when the command exists' do
        before :each do
          described_class.expects(:`).with(command).returns(command_out)
        end

        it 'is expected to return the command output' do
          expect(described_class.run_if_available(command)).to eq(command_out)
        end
      end

      context 'when the command does not exists' do
        before :each do
          described_class.expects(:`).with(command).raises(Errno::ENOENT)
        end

        it 'is expected to return nil' do
          expect(described_class.run_if_available(command)).to be_nil
        end
      end
    end

    describe 'collect_metrics' do
      it 'should raise a NotImplementedError' do
        expect { subject.collect_metrics("", "") }.to raise_error(NotImplementedError)
      end
    end

    describe 'available?' do
      it 'is expected to raise NotImplementedError' do
        expect { subject.available? }.to raise_error(NotImplementedError)
      end
    end

    describe 'parse_supported_metrics' do
      subject { described_class.new("", "", []) }
      let(:metrics) { {metrics:
                        {flog:
                          {name: "Pain",
                           description: "",
                           scope: "METHOD",
                           type: "NativeMetricSnapshot"},
                         saikuro:
                          {name: "Cyclomatic Complexity",
                           description: "",
                           scope: "METHOD",
                           type: "NativeMetricSnapshot"}
                        }
                      }
                    }

      before :each do
        YAML.expects(:load_file).with("lib/metric_collector/native/metric_fu/metrics.yml").returns(metrics)
      end

      it 'is expected to return a code => Metric hash' do
        supported_metrics = { flog: FactoryGirl.build(:flog_metric, description: ''),
                              saikuro: FactoryGirl.build(:saikuro_metric, description: '') }

        expect(subject.parse_supported_metrics("lib/metric_collector/native/metric_fu/metrics.yml", "MetricFu", [:RUBY])).to eq(supported_metrics)
      end
    end
  end
end
