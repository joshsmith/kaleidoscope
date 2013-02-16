require 'spec_helper'

describe Kaleidoscope::Configuration do
  describe 'when no colors are specified' do
    before do
      Kaleidoscope.configure do |config|
      end
    end

    it 'has no colors' do
      colors = Kaleidoscope.configuration.colors
      colors.should be_nil
    end
  end

  describe 'when colors are specified inside a configuration block' do
    before do
      Kaleidoscope.configure do |config|
        config.colors = ["#FFFFFF"]
      end
    end

    it 'sets the colors' do
      Kaleidoscope.configuration.colors.should eq ["#FFFFFF"]
    end
  end

  describe 'when colors are specified outside a configuration block' do
    it 'sets the colors' do
      Kaleidoscope.configuration.colors = ["#FFFFFF"]
      Kaleidoscope.configuration.colors.should eq ["#FFFFFF"]
    end
  end
end