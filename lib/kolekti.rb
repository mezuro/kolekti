require 'kalibro_client'

require "kolekti/version"
require "kolekti/runner"
require "kolekti/entities"

module Kolekti
  COLLECTORS = []

  def self.register_collector(collector)
    COLLECTORS << collector
  end
end
