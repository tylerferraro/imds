module IMDS
  class Count < Command
    def initialize(key)
      @name = :count
      @key = key
    end

    def execute(store)
      puts store.count(@key)
    end
  end
end