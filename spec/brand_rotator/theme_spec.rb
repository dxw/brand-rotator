require "brand_rotator/theme"

describe BrandRotator::Theme do
  subject { BrandRotator::Theme }

  describe ".today" do
    it "returns a theme" do
      expect(subject.today).to match(
        marque: instance_of(String),
        foreground_colour: instance_of(String),
        background_colour: instance_of(String)
      )
    end
  end
end
