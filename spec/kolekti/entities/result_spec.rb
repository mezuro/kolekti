require 'spec_helper'

describe Kolekti::Entities::Result, pending: 'Probably will go away soon, replaced by PersistenceStrategy' do
  describe 'class_methods' do
    describe 'result_queue' do
      context 'with an empty queue' do
        it 'is expected to return the queue of metric results' do
          expect(described_class.result_list).to eq([])
        end
      end

      context 'with a non empty queue' do
        it 'is expected to return the queue of metric results' do
          expect(described_class.result_list).to eq([])
        end
      end
    end

    describe 'signal' do
      let(:result_queue) { FactoryGirl.build(:result_queue) }

      before :each do
        described_class.result_queue = result_queue
      end

      it 'is expected to empty the queue' do
        described_class.signal
        expect(described_class.result_queue).to be_empty
      end
    end
  end

  describe 'methods' do
    describe 'save' do
      let(:empty_result_queue) { FactoryGirl.build(:empty_result_queue) }

      before :each do
        described_class.result_queue = empty_result_queue
      end

      it 'is expected to add to a queue of results' do
        result = described_class.new
        result.save
        expect(described_class.result_queue).to include(result)
      end
    end
  end
end
