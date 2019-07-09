# frozen_string_literal: true

require 'fluent/plugin/input'

class Fluent::Redis_SlowlogInput < Fluent::Plugin::Input
  Fluent::Plugin.register_input('redis_slowlog', self)

  config_param :tag,      :string
  config_param :host,     :string,   default: nil
  config_param :port,     :integer,  default: 6379
  config_param :logsize,  :integer,  default: 128
  config_param :interval, :integer,  default: 10

  def initialize
    super
    require 'redis'
  end

  def configure(conf)
    super
    @log_id = 0
    @get_interval = @interval
  end

  def start
    super
    @redis = Redis.new(host: @host, port: @port, thread_safe: true)
    pong = @redis.ping
    unless pong == 'PONG'
      raise 'fluent-plugin-redis-slowlog: cannot connect redis'
    end

    @watcher = Thread.new(&method(:watch))
  end

  def shutdown
    super
    @redis.quit
  end

  private

  def watch
    loop do
      sleep @get_interval
      @log_id = output(@log_id)
    end
  end

  def output(last_id = 0)
    slow_logs = @redis.slowlog('get', logsize)
    log_id = slow_logs[0][0]
    slow_logs.reverse.each do |log|
      next unless log[0] > last_id || log.nil?

      log_hash = { id: log[0], timestamp: Time.at(log[1]), exec_time: log[2], command: log[3] }
      Fluent::Engine.emit(tag, Time.now.to_i, log_hash)
    end
    log_id
  end
end
