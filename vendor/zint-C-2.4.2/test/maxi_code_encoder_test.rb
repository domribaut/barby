require 'minitest/spec'
require 'minitest/autorun'

require '../lib/maxi_code_encoder' #TODO fix setup


module MaxiCodeEncoder
  class TestCase < MiniTest::Spec
    it "should recognize a maxicode id" do
      MaxiCodeEncoder::ZBarcode_ValidID(MaxiCodeEncoder::BARCODE_MAXICODE).must_equal 1
    end

    it "should not recognize a not existing id" do
      MaxiCodeEncoder::ZBarcode_ValidID(4266642).must_equal 0
    end

    it "should be able to build a zint_symbol with maxicode symbologi" do
      zint_symbol = MaxiCodeEncoder::ZBarcode_Create()
      zint_symbol[:symbology] = MaxiCodeEncoder::BARCODE_MAXICODE
      zint_symbol[:symbology].must_equal MaxiCodeEncoder::BARCODE_MAXICODE
    end

    it "should retrieve encoding for input" do
      zint_symbol = MaxiCodeEncoder::ZBarcode_Create()
      zint_symbol[:symbology] = MaxiCodeEncoder::BARCODE_MAXICODE

      len = MaxiCodeEncoder::ZBarcode_Encode (zint_symbol, 'min input'.top, 9)

      if len < 0
        encode = "error, code = " + len
      else
        strPtr = zint_symbol[:encoded_data]
        encode =   strPtr.null? ? [] : ptr.get_array_of_string(0, len).compact
      end
      p encode.to_s
    end

  end

end
