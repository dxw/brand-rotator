require "base64"
require "RMagick"
require_relative "../brand_rotator"

module BrandRotator
  class Image
    class << self
      def open_svg_asset_as_base64_png(svg_name, width: nil)
        png_blob = open_svg_asset_as_png(svg_name, width: width)

        Base64.strict_encode64(png_blob)
      end

      def open_svg_asset_as_png(svg_name, width: nil)
        svg_path = File.expand_path(
          File.join(
            File.dirname(__FILE__),
            "..", # brand_rotator
            "..", # lib
            "assets",
            "#{svg_name}.svg"
          )
        )

        open_svg_as_png(svg_path, width: width)
      end

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
