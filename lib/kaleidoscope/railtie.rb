require 'kaleidoscope'

module Kaleidoscope
  require 'rails'

  class Railtie < Rails::Railtie
    initializer 'kaleidoscope.insert_into_active_record' do |app|
      ActiveSupport.on_load :active_record do
        Kaleidoscope::Railtie.insert
      end
    end

    rake_tasks { load "tasks/kaleidoscope.rake" }
  end

  class Railtie
    def self.insert
      Kaleidoscope.options[:logger] = Rails.logger

      if defined?(ActiveRecord)
        Kaleidoscope.options[:logger] = ActiveRecord::Base.logger
        ActiveRecord::Base.send(:include, Kaleidoscope::Glue)
      end
    end
  end
end