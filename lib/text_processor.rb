require 'open3'

module TextProcessor
  class CommandError < StandardError; end

  class ::String
    def to_command_class
      begin
        ::TextProcessor.const_get(split('_').map(&:capitalize).join(''))
      rescue NameError => e
        raise CommandError, "#{self} is an unsupported command"
      end
    end
  end

  class TextProcessor

    def initialize(commands, text)
      @commands = commands&.map(&:to_command_class)
      @text     = text.strip
    end

    def process
      @commands.map do |command|
        @text = command.exec(@text)
      end.last
    end
  end

  class Command
    def self.exec
      raise CommandError, 'Command not implemented'
    end
  end

  class Sort < Command
    def self.exec(text)
      Open3.capture3('sort', stdin_data: text)[0].strip
    end
  end

  class Uniq < Command
    def self.exec(text)
      text = Sort.exec(text)
      Open3.capture3('uniq', stdin_data: text)[0].strip
    end
  end

  class Split < Command
    def self.exec(text)
      Open3.capture3('tr -s "[:space:]" "\n"', stdin_data: text)[0].strip
    end
  end

  class Upper < Command
    def self.exec(text)
      Open3.capture3('tr -s "[:lower:]" "[:upper:]"', stdin_data: text)[0].strip
    end
  end

  class Lower < Command
    def self.exec(text)
      Open3.capture3('tr -s "[:upper:]" "[:lower:]"', stdin_data: text)[0].strip
    end
  end

end