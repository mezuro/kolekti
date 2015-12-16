require 'spec_helper'

class TestBase < Kolekti::Entities::Base
  attr_accessor :test
end

describe Kolekti::Entities::Base do
  describe 'initialization' do
    context 'with invalid attributes' do
      it 'is expected to raise a NoMethodError' do
        expect { described_class.new({invalid_attr: 1}) }.to raise_error(NoMethodError)
      end
    end

    context 'with a valid attribute' do
      subject { TestBase.new(test: 'test') }

      it 'is expected to fill in the attribute' do
        expect(subject.test).to eq('test')
      end
    end
  end

  describe 'method' do
    describe 'save' do
      it 'is expected to put that record on the persistence queue and freeze the object' do
        expect(Kolekti::Entities::PERSISTENCE_QUEUE).to be_empty # Ensure the Queue is empty

        subject.save

        expect(Kolekti::Entities::PERSISTENCE_QUEUE.pop).to eq(subject)
        expect(subject.frozen?).to be_truthy
      end
    end
  end

  describe 'class method' do
    describe 'create' do
      let(:attributes) { {test: 'test'} }
      let(:instance) { mock('instance') }

      it 'is expected to instantiate a new object and save it' do
        instance.expects(:save)
        described_class.expects(:new).with(attributes).returns(instance)

        described_class.create(attributes)
      end
    end
  end
end