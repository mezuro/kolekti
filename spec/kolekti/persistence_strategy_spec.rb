require 'spec_helper'

describe Kolekti::PersistenceStrategy do
  describe 'methods' do
    subject { described_class.new }

    describe 'create_tree_metric_result' do
      it 'is expected to raise a NotImplementedError' do
        expect do
          subject.create_tree_metric_result('module_name', 12,
                                            KalibroClient::Entities::Miscellaneous::Granularity::METHOD)
        end.to raise_error NotImplementedError
      end
    end

    describe 'create_hotspot_metric_result' do
      it 'is expected to raise a NotImplementedError' do
        expect { subject.create_hotspot_metric_result('module_name', 10, 'mess') }.to raise_error NotImplementedError
      end
    end
  end
end
