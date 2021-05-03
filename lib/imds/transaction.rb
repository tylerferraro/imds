module IMDS
  class Transaction
    attr_reader :rollback_data

    def initialize
      @rollback_data = {}
    end

    def add_rollback_data(key, value)
      @rollback_data[key] = value unless @rollback_data.has_key?(key)
    end
  end
end