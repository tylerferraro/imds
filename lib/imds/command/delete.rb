module IMDS
  class Delete < Command
    def initialize(key)
      @name = :delete
      @key = key
    end

    def execute(store)
      store.delete(@key)
    end
  end
end