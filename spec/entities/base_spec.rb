require 'spec_helper'

describe Kolekti::Entities::Base do
  describe 'methods' do
    describe 'save' do
      it 'is expected to put that record on the persistence queue and freeze the object' do
        expect(Kolekti::Entities::PERSISTENCE_QUEUE).to be_empty # Ensure the Queue is empty

        subject.save

        expect(Kolekti::Entities::PERSISTENCE_QUEUE.pop).to eq(subject)
        expect(subject.frozen?).to be_truthy
      end
    end
  end
end