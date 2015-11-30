require 'spec_helper'

describe Kolekti do
  it 'has a version number' do
    expect(Kolekti::VERSION).not_to be nil
  end

  describe 'methods' do
    describe 'register_collector' do
      it 'is expected to add a collector to the list' do
        Kolekti.register_collector(Object)

        expect(Kolekti::COLLECTORS).to include(Object)
      end
    end
  end
end
