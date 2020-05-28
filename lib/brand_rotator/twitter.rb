require_relative "../brand_rotator"

module BrandRotator::Twitter
  PROFILE_IMAGES = Dir[
    File.join(File.dirname(__FILE__), "..", "..", "assets", "marques", "*")
  ]
    .select { |path| !File.directory?(path) }
    .map { |path|
      path.sub(File.join(File.dirname(__FILE__), "..", "..", "assets", ""), "")
    }
    .freeze
end
