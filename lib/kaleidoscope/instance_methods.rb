module Kaleidoscope
  module InstanceMethods
    def colors_for
    end

    def generate_colors
      Kaleidoscope.log("Generating colors for #{self.class.model_name}.")
    end

    def destroy_colors
      Kaleidoscope.log("Deleting colors for #{self.class.model_name}.")
    end
  end
end