require_relative "../brand_rotator"

module BrandRotator::Config
  COLOURS = {
    "blue-light" => "73C3D5",
    "blue-mid" => "009ABF",
    "blue" => "004876",
    "ivory" => "F9F8F5",
    "navy" => "243746",
    "orange-light" => "FFA489",
    "orange-mid" => "FF8D6B",
    "orange" => "FF5C35",
    "purple-light" => "A7A4DF",
    "purple-mid" => "7473C0",
    "purple" => "69488E",
    "red-light" => "FFB1B9",
    "red" => "FF595A",
    "teal-light" => "80C7BC",
    "teal-mid" => "009490",
    "teal" => "09615D",
    "yellow-light" => "FCD672",
    "yellow-mid" => "FFB259"
  }.freeze

  THEMES = Dir[
    File.join(File.dirname(__FILE__), "..", "..", "assets", "marques", "*")
  ]
    .select { |path| !File.directory?(path) }
    .map { |path|
      colours = /\/d-(\w+(-light|-mid)?)-(\w+(-light|-mid)?).svg$/.match(path)
      foreground_colour = colours[1]
      background_colour = colours[3]

      {
        marque: path
          .sub(
            File.join(File.dirname(__FILE__), "..", "..", "assets", ""),
            ""
          )
          .sub(".svg", ""),
        foreground_colour: COLOURS.fetch(foreground_colour),
        background_colour: COLOURS.fetch(background_colour)
      }
    }
    .freeze
end
