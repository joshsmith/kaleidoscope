require 'rails'
require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/kaleidoscope/install_generator'

describe 'TestMigration' do
  include GeneratorSpec::TestCase
  tests InstallGenerator
  destination File.expand_path("../tmp", __FILE__)
  arguments %w(install)

  before do
    prepare_destination
    run_generator
  end

  it 'Should create a correct initializer file' do
    assert_file 'config/initializers/kaleidoscope.rb' do |initializer|
    end
  end
end