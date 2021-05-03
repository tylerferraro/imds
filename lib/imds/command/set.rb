module IMDS
  class Set < Command
    def initialize(key, value)
      @name = :set
      @key = key
      @value = value
    end

    def execute(store)
      store.set(key, value)
    end
  end
end