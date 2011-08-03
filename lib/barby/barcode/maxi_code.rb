require 'rqrcode'
require 'barby/barcode'
require 'maxi_code_encoder'

module Barby

  class MaxiCode < Barcode2D

    def encoding
      zint_symbol = MaxiCodeEncoder::ZBarcode_Create()
      zint_symbol[:symbology] = MaxiCodeEncoder::BARCODE_MAXICODE
      zint_symbol[:input_mode] = MaxiCodeEncoder::UNICODE_MODE
      zint_symbol[:option_1] = 3
      zint_symbol[:primary] = "51147    276066"
      real_ish_input = "[)>\x1e01\x1c9651147 \x1c276\x1c066\x1c1Z12345679\x1cUPSN\x1c\x1c\x1c\x1c\x1c\x1c\x1c\x1c\x1c\x1e\x4"
      MaxiCodeEncoder::ZBarcode_Encode(zint_symbol, real_ish_input, 0)

      MaxiCodeEncoder::encoding zint_symbol

    end

    def maxi_code?
      true
    end

  end


end
