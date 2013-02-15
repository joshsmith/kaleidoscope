module Kaleidoscope
  module Task
    def self.obtain_class
      class_name = ENV['CLASS'] || ENV['class']
      raise "Must specify CLASS" unless class_name
      class_name
    end
  end
end

namespace :kaleidoscope do
  desc "Refreshes color data."
  task :refresh => ["kaleidoscope:refresh"]

  namespace :refresh do
    desc "Refreshes color data for a given CLASS."
  end
end