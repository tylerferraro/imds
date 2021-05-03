module IMDS
  class Rollback < Command
    def initialize
      @name = :rollback
    end

    def execute(store)
      puts 'TRANSACTION NOT FOUND' unless store.rollback
    end
  end
end