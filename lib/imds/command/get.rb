module IMDS
  class Get < Command
    def initialize(key)
      @name = :get
      @key = key
    end

    def execute(store)
      puts store.get(key) || 'NULL'
    end
  end
end