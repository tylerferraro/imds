module IMDS
  class REPL
    attr_reader :store

    def initialize
      @store = Store.new
    end

    def run
      while true
        print '>> '
        line = gets.chomp
        next if line.empty?

        command = Command.parse(line)
        return if command.name == :end

        command.execute(store)
      end
    end
  end
end