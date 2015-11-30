module Kolekti
  module Runner
    class Base
      def self.run(repository_path)
        raise NotImplementedError
      end

      def self.clear(repository_path)
        raise NotImplementedError
      end
    end
  end
end