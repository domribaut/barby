require 'test_helper'

class AsciiOutputterTest < Barby::TestCase

  it "should render nil values and bar with special maxicode-characters O and H" do
    load_outputter('ascii')
    barcode = Barby::MaxiCode.new('Encoding is hardcoded in MaxiCode')
    AsciiOutputter.new(barcode)

    to_ascii = barcode.to_ascii

    File.open("out.txt", 'w') {|f| f.write(to_ascii) }

    to_ascii.must_include "O"       # bull eye
    to_ascii.must_include "H"       # use H to represent hexagones
    refute_includes to_ascii, "X"   # usual  representation of 2D bar

  end

end





