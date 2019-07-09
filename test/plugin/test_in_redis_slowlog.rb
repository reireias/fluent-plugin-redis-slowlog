# frozen_string_literal: true

require 'helper'

class Redis_SlowlogInputTest < Test::Unit::TestCase
  CONFIG = %(
      tag redis-slowlog
      host localhost
      port 6379
      logsize 128
      interval 10
  )

  def setup
    Fluent::Test.setup
  end

  def create_driver(conf = CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::Redis_SlowlogInput).configure(conf)
  end

  def test_configure; end
end
