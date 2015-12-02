require 'spec_helper'


describe Kolekti::Runner::Base do
  describe 'methods' do
    describe 'inherited' do
      it 'is expecteed to register every subclass to Runner::IMPLEMENTED' do
        class RunnerDouble < Kolekti::Runner::Base; end
        expect(Kolekti::Runner::IMPLEMENTED).to include(RunnerDouble)
      end
    end

    describe 'metric_codes' do
      it 'is expected to raise a NotImplementedError' do
        expect { Kolekti::Runner::Base.metric_codes }.to raise_error(NotImplementedError)
      end
    end

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