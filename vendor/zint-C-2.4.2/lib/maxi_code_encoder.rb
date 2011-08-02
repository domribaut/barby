require 'ffi'

module MaxiCodeEncoder
  extend FFI::Library
  ffi_lib 'libzint.2.4.2'

  BARCODE_MAXICODE = 57
  BARCODE_CODE128 = 20
  UNICODE_MODE = 1

  class DataArray < FFI::Struct
    layout :array, [:uchar, 178]

    def [](idx)
      if idx.is_a?(Integer)
        self[:array][idx]
      else
        super(idx)
      end
    end

    def []=(idx, val)
      if idx.is_a?(Integer)
        self[:array][idx] = val
      else
        super(idx, val)
      end
    end



  end

  class ZINT_SYMBOL < FFI::Struct

    layout :symbology, :int,
           :height, :int,
           :whitespace_width, :int,
           :border_width, :int,
           :output_options, :int,
           :fgcolour, [:char, 10],
           :bgcolour, [:char, 10],
           :outfile, [:char, 256],
           :scale, :float,
           :option_1, :int,
           :option_2, :int,
           :option_3, :int,
           :show_hrt, :int,
           :input_mode, :int,
           :text, [:uchar,128],
           :rows, :int,
           :width, :int,
           :primary, [:char, 128],
           :encoded_data, [DataArray, 143],
           :row_height, [:int, 178],
           :errtxt, [:char, 100]

    def encoded_data_row_as_string idx
        #todo add validation of idx
        self[:encoded_data][idx].to_ptr.read_string
    end

  end


  attach_function :ZBarcode_ValidID, [:int], :int
  attach_function :ZBarcode_Create, [], ZINT_SYMBOL.by_ref;
  attach_function :ZBarcode_Encode, [:pointer, :string, :int], :int
  attach_function :module_is_set, [:pointer, :int, :int], :int
  #ZINT_EXTERN int ZBarcode_Encode(struct zint_symbol *symbol, unsigned char *input, int length);

end

=begin
legge til relevante felt fra

struct zint_symbol {
	int symbology;
	int height;
	int whitespace_width;
	int border_width;
	int output_options;
	char fgcolour[10];
	char bgcolour[10];
	char outfile[256];
	float scale;
	int option_1;
	int option_2;
	int option_3;
	int show_hrt;
	int input_mode;
	unsigned char text[128];
	int rows;
	int width;
	char primary[128];
	unsigned char encoded_data[178][143];
	int row_height[178]; /* Largest symbol is 177x177 QR Code */
	char errtxt[100];
	char *bitmap;
	int bitmap_width;
	int bitmap_height;
	struct zint_render *rendered;
};
=end
