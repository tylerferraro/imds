module IMDS
  class Store
    def initialize(data = {})
      @data = data
      @transactions = []
    end

    def get(key)
      @data[key]
    end

    def set(key, value)
      current_transaction&.add_rollback_data(key, @data[key])
      @data[key] = value
    end

    def delete(key)
      current_transaction&.add_rollback_data(key, @data[key])
      @data.delete(key)
    end

    def count(value)
      @data.values.count { |v| v == value }
    end

    def begin_transaction
      @transactions.push(Transaction.new)
    end

    def rollback
      transaction = @transactions.pop
      return false if transaction.nil?

      transaction.rollback_data.each do |key, value|
        if value.nil?
          @data.delete(key)
        else
          @data[key] = value
        end
      end

      true
    end

    def commit
      @transactions = []
    end

    private

    attr_accessor :data, :transactions

    def current_transaction
      transactions.last
    end
  end
end