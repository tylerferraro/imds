module IMDS
  class Begin < Command
    def initialize
      @name = :begin
    end

    def execute(store)
      store.begin_transaction
    end
  end
end