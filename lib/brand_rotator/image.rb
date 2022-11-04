require "base64"
require "rmagick"
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
        image_array = Magick::Image.read(svg_path) do |img|
          img.format = "SVG"
          img.background_color = "transparent"
        end
        image = image_array.first

        image.resize_to_fit!(width) unless width.nil?

        image.to_blob { |img| img.format = "PNG" }
      end
    end
  end
end
