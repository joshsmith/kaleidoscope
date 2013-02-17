module Kaleidoscope
  module Glue
    def self.included(base)
      base.extend ClassMethods
    end
  end
end