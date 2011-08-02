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

    it "should retrieve encoded data" do
      zint_symbol = MaxiCodeEncoder::ZBarcode_Create()
      zint_symbol[:encoded_data][0][0] = 48
      zint_symbol[:encoded_data][0][1] = 49
      zint_symbol[:encoded_data][1][0] = 48
      zint_symbol[:encoded_data][1][1] = 49
      zint_symbol[:encoded_data][2][0] = 49
      zint_symbol[:encoded_data][2][1] = 49
      #read them back
      zint_symbol.encoded_data_row_as_string(0).must_equal "01"
      zint_symbol.encoded_data_row_as_string(1).must_equal "01"
      zint_symbol.encoded_data_row_as_string(2).must_equal "11"
      zint_symbol.encoded_data_row_as_string(3).must_equal ""
    end

  end

end
