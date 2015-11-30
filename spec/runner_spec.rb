require 'spec_helper'

describe Kolekti::Runner::Base do
  describe 'methods' do
    describe 'run' do
      it 'is expected to raise a NotImplementedError' do
        expect { Kolekti::Runner::Base.run('') }
      end
    end

    describe 'clear' do
      it 'is expected to raise a NotImplementedError' do
        expect { Kolekti::Runner::Base.clear('') }
      end
    end
  end
end