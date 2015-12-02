require 'spec_helper'

describe Kolekti::Runner::Base do
  describe 'methods' do
    describe 'run' do
      it 'is expected to raise a NotImplementedError' do
        expect { Kolekti::Runner::Base.run('') }.to raise_error(NotImplementedError)
      end
    end

    describe 'clear' do
      it 'is expected to raise a NotImplementedError' do
        expect { Kolekti::Runner::Base.clear('') }.to raise_error(NotImplementedError)
      end
    end
  end
end