module Kaleidoscope
  class InstallGenerator < Rails::Generators::Base
    desc "Create a migration to add kaleidoscope models."

    def self.source_root
      @source_root ||= File.expand_path('../templates', __FILE__)
    end

    def copy_initializer
      template "kaleidoscope.rb", "config/initializers/kaleidoscope.rb"
    end
  end
end