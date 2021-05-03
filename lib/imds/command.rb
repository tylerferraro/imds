module IMDS
  class Command
    attr_reader :name, :key, :value

    def execute(store)
      raise Error.new('Must implement in child functions')
    end

    class << self
      def parse(str)
        segments     = str.split
        command_id   = segments[0].downcase.to_sym
        key          = segments[1].to_sym
        value        = segments[2]

        create(command_id, key, value)
      rescue => e
        puts e.inspect
        UnsupportedCommand.new(segments[0])
      end

      private

      def create(id, key, value)
        case id
        when :get then Get.new(key)
        when :set then Set.new(key, value)
        when :delete then Delete.new(key)
        when :count then Count.new(key)     # In this case key is the value to count
        when :begin then Begin.new
        when :rollback then Rollback.new
        when :commit then Commit.new
        when :end then End.new
        else 
          UnsupportedCommand.new(id)
        end
      end
    end
  end
end