$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'diplomacy'

require 'minitest/autorun'
require 'pathname'
require 'yaml'

module Minitest
  class Test
    def load_yaml(name)
      file = Pathname.new(__dir__).parent.join('data', "#{name}.yml").open
      YAML.safe_load file
    end
  end
end
