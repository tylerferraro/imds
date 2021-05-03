module IMDS
  class Commit < Command
    def initialize
      @name = :commit
    end

    def execute(store)
      store.commit
    end
  end
end