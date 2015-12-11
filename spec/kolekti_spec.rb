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
  end
end
