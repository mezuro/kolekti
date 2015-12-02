module Kolekti
  module Runner
    class Base
      def self.inherited(subclass)
        Runner::IMPLEMENTED << subclass
      end

      def self.metric_codes
        raise NotImplementedError
      end

      def self.run(repository_path)
        raise NotImplementedError
      end

      def self.clear(repository_path)
        raise NotImplementedError
      end
    end
  end
end
