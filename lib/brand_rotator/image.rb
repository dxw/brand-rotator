require "RMagick"
require_relative "../brand_rotator"

module BrandRotator
  class Image
    class << self
      def open_svg_as_png(svg_path, width: nil)
        image_array = Magick::Image.read(svg_path) {
          self.format = "SVG"
          self.background_color = "transparent"
        }
        image = image_array.first

        image.resize_to_fit!(width) unless width.nil?

        image.to_blob {
          self.format = "PNG"
        }
      end
    end
  end
end