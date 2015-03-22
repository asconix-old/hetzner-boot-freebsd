require 'benchmark'
require 'logger'

require 'hetzner-api'
require 'hetzner/boot/freebsd/version'
require 'hetzner/boot/freebsd/target'

module Hetzner
  module Boot
    class FreeBSD
      attr_accessor :targets
      attr_accessor :api
      attr_accessor :actions
      attr_accessor :logger

      def initialize(options = {})
        @targets = []
        @actions = %w(
          remove_from_local_known_hosts
          enable_rescue_mode
          reset
          wait_for_ssh_down
          wait_for_ssh_up
          update_local_known_hosts
          verify_installation
        )
        @api = options[:api]
        @logger = options[:logger] || Logger.new(STDOUT)
      end

      def add_target(param)
        if param.is_a? Hetzner::Boot::FreeBSD::Target
          @targets << param
        else
          @targets << (Hetzner::Boot::FreeBSD::Target.new param)
        end
      end

      def <<(param)
        add_target param
      end

      def bootstrap!(options = {})
        @targets.each do |target|
          target.use_api @api
          target.use_logger @logger
          bootstrap_one_target! target
        end
      end

      def bootstrap_one_target!(target)
        actions = (target.actions || @actions)
        actions.each_with_index do |action, index|
          loghack = "\b" * 24 # remove: "[bootstrap_one_target!] ".length
          target.logger.info "#{loghack}[#{action}] #{sprintf "%-20s", "START"}"
          d = Benchmark.realtime do
            target.send action
          end
          target.logger.info "#{loghack}[#{action}] FINISHED in #{sprintf "%.5f",d} seconds"
        end
      rescue => e
        target.logger.error "Something bad happened unexpectedly: #{e.class} => #{e.message}"
      end
    end
  end
end
