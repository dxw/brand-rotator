require "brand_rotator/image"
require "RMagick"

describe BrandRotator::Image do
  subject { BrandRotator::Image }

  describe ".open_svg_as_png" do
    it "returns a PNG" do
      image_path = File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "..",
          "fixtures",
          "image.svg"
        )
      )

      expect(subject.open_svg_as_png(image_path, width: 100))
        .to match(Regexp.new("^\x89PNG".force_encoding("binary")))
    end

    it "returns an image with the given dimensions" do
      image_path = File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "..",
          "fixtures",
          "image.svg"
        )
      )

      blob = subject.open_svg_as_png(image_path, width: 123)

      image = Magick::Image.from_blob(blob).first

      expect(image.columns).to eql(123)
      expect(image.rows).to eql(123)
    end
  end
end
