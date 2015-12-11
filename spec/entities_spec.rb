require 'spec_helper'

describe Kolekti::Entities do
  describe 'PERSISTENCE_QUEUE' do
    it 'is expected to be a Queue' do
      expect(described_class::PERSISTENCE_QUEUE).to be_a(Queue)
    end
  end
end
