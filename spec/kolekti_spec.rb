require 'spec_helper'

describe Kolekti do
  let(:collector) { FactoryGirl.build(:collector) }

  it 'has a version number' do
    expect(Kolekti::VERSION).not_to be nil
  end

  describe 'methods' do
    context 'altering collectors state' do
      before :each do
        Kolekti.register_collector(collector)
      end

      after :each do
        Kolekti.unregister_collector(collector)
      end

      describe 'register_collector' do
        it 'is expected to add a collector to the list' do
          expect(Kolekti::COLLECTORS).to include(collector)
        end
      end

      describe 'collectors' do
        it 'is expected to return the current collectors' do
          expect(Kolekti.collectors).to include(collector)
        end
      end
    end

    describe 'unregister_collector' do
      context 'with an unregistered collector' do
        it 'is expected to raise an ArgumentError' do
          expect { Kolekti.unregister_collector(collector) }.to raise_error(ArgumentError)
        end
      end

      context 'with a registered collector' do
        before do
          Kolekti.register_collector(collector)
        end
        it 'is expected to remove the collector from the list' do
          Kolekti.unregister_collector(collector)
          expect(Kolekti::COLLECTORS).not_to include collector
        end
      end
    end

    describe 'available_collectors' do
      context 'with no registered collector' do
        it 'is expected to return an empty list' do
          expect(Kolekti.available_collectors).to be_empty
        end
      end

      context 'with no available collectors' do
        let(:collector) { FactoryGirl.build(:collector) }

        before do
          Kolekti.register_collector(collector)
          collector.expects(:available?).returns false
        end

        after do
          Kolekti.unregister_collector(collector)
        end

        it 'is expected to return an empty list' do
          expect(Kolekti.available_collectors).to be_empty
        end
      end

      context 'with some available adn some unavailable collectors' do
        let(:collectors) { FactoryGirl.build_list(:collector, 3) }

        before do
          collectors.each(&Kolekti.method(:register_collector))
          collectors[0].expects(:available?).returns true
          collectors[1].expects(:available?).returns true
          collectors[2].expects(:available?).returns false
        end

        after do
          collectors.each(&Kolekti.method(:unregister_collector))
        end

        it 'is expected to return a list with the available collectors' do
          expect(Kolekti.available_collectors).to eq collectors[0..1]
        end
      end
    end

    describe 'default_metric_value' do
      let(:metric) { FactoryGirl.build(:native_metric) }
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration, metric: metric) }

      context 'with an existing collector' do
        let(:value) { 1337 }

        before :each do
          collector.expects(:name).returns(metric_configuration.metric.metric_collector_name)
          Kolekti.expects(:collectors).returns([collector])
        end

        it "is expected to get the metric's collector default value" do
          collector.expects(:default_value_from).with(metric_configuration).returns(value)

          expect(Kolekti.default_metric_value(metric_configuration)).to eq(value)
        end
      end

      context 'without an existing collector' do
        before :each do
          Kolekti.expects(:collectors).returns([])
        end

        it 'is expected to return nil' do
          expect(Kolekti.default_metric_value(metric_configuration)).to be_nil
        end
      end
    end
  end
end
