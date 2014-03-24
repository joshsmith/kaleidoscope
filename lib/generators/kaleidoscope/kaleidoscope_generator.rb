require 'rails/generators/active_record'

class KaleidoscopeGenerator < ActiveRecord::Generators::Base
  desc "Create a migration to add kaleidoscope models."

  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end

  def generate_migration
    migration_template "kaleidoscope_migration.rb.erb", "db/migrate/#{migration_file_name}"
  end

  def migration_file_name
    "#{migration_name}.rb"
  end

  private

  def migration_name
    "create_#{name.underscore}_colors"
  end

  def migration_class_name
    migration_name.camelize
  end
end