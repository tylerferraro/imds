module IMDS
  class UnsupportedCommand < Command
    def initialize(key = nil)
      @name = key || :unknown
    end

    def execute(store)
      puts "Unsupported Command: #{@name}"
    end
  end
end