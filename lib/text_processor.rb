module TextProcessor
  class CommandError < StandardError; end

  class ::String
    def to_command_class
      begin
        TextProcessor.const_get(split('_').map(&:capitalize).join(''))
      rescue NameError => e
        raise CommandError, "#{self} is an unsupported command"
      end
    end
  end

  class TextProcessor

    def initialize(commands, text)
      @commands = commands&.map(&:to_command_class)
      @text     = text
    end

    def process

    end
  end
end