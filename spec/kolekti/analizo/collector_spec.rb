require 'tmpdir'
require 'fileutils'

require 'spec_helper'
require 'kalibro_client'

describe Kolekti::Analizo::Collector do
  describe 'run_wanted_metrics' do
    let(:metric_configurations) { [FactoryGirl.build(:metric_configuration)] }
    let(:strategy) { Kolekti::TestPersistenceStrategy.new }
    subject { described_class.new }

    context 'with a C++ repository' do
      let(:repository_path) { Dir::mktmpdir }
      let(:runner) { Kolekti::Runner.new(repository_path, metric_configurations, strategy) }

      before :each do
        Kolekti.register_collector(subject)
      end

      after :each do
        Kolekti.unregister_collector(subject)
      end

      it 'is expected to run the wanted metrics' do
        begin
          # FIXME: Find a beter way to clone and clean the repository to be analized
          unless `git clone -q 'https://github.com/rafamanzo/runge-kutta-vtk.git' '#{repository_path}'`
            raise StandardError.new('git clone failed')
          end
          runner.run_wanted_metrics
        ensure
          FileUtils.rm_rf(repository_path)
        end
      end
    end
  end
end
