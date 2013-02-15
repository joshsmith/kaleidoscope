require 'rails'
require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/kaleidoscope/kaleidoscope_generator'

describe 'TestMigration' do
  include GeneratorSpec::TestCase
  tests KaleidoscopeGenerator
  destination File.expand_path("../tmp", __FILE__)
  arguments %w(photo)

  let(:time) { Time.new.utc.strftime("%Y%m%d%H%M%S") }

  before do
    prepare_destination
    run_generator
  end

  it 'Should create a correct migration file' do
    # @time = time
    # raise @time.to_yaml
    assert_migration 'db/migrate/create_photo_colors' do |migration|
      assert_match /class CreatePhotoColors/, migration

      assert_method :change, migration do |change|
        expected = <<MIGRATION
          create_table :photo_colors do |t|
            t.integer :photo_id
            t.string :original_color
            t.string :reference_color
            t.float :frequency
            t.integer :distance

            t.timestamps
          end

          add_index :photo_colors, :photo_id
          add_index :photo_colors, :original_color
          add_index :photo_colors, :reference_color
          add_index :photo_colors, :frequency
          add_index :photo_colors, :distance
MIGRATION

        assert_equal expected.squish, change.squish
      end
    end
  end

  it 'Should not create the migration without required arguments' do
    prepare_destination
    silence_stream(STDERR) { run_generator %w() }
    assert_no_migration 'db/migrate/create_photo_colors'
  end
end