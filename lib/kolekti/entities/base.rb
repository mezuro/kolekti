module Kolekti
  module Entities
    class Base
      def save
        self.freeze # Ensure that no changes are made after the object has been queued for persistence
        Kolekti::Entities::PERSISTENCE_QUEUE.enq(self)

      end
    end
  end
end
