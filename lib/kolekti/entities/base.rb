module Kolekti
  module Entities
    class Base
      def initialize(attributes={})
        attributes.each { |field, value| send("#{field}=", value) }
      end

      def save
        self.freeze # Ensure that no changes are made after the object has been queued for persistence
        Kolekti::Entities::PERSISTENCE_QUEUE.enq(self)
      end

      def self.create(attributes={})
        self.new(attributes).save
      end
    end
  end
end
