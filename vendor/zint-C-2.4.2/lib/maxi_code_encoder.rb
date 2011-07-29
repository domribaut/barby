require 'ffi'

module MaxiCodeEncoder
  extend FFI::Library
  ffi_lib 'libzint.2.4.2'

  class ZINT_SYMBOL < FFI::Struct
   # attr_accessor :symbology
    layout :symbology, :int,
           :encoded_data, [:uchar, 178] #WIP
  end


  attach_function :ZBarcode_ValidID, [ :int ] , :int
  attach_function :ZBarcode_Create,[], ZINT_SYMBOL.by_ref;
  attach_function  :ZBarcode_Encode, [ZINT_SYMBOL, :uchar,:int ], :int
  #ZINT_EXTERN int ZBarcode_Encode(struct zint_symbol *symbol, unsigned char *input, int length);

  #??
  #ZINT_EXTERN struct zint_symbol *ZBarcode_Create(void);
  #define BARCODE_MAXICODE        57



end

p "MaxiCodeEncoder::ZBarcode_ValidID 57: " + MaxiCodeEncoder::ZBarcode_ValidID(57).to_s
p "MaxiCodeEncoder::ZBarcode_ValidID 424242: " + MaxiCodeEncoder::ZBarcode_ValidID(424242).to_s
zint_symbol = MaxiCodeEncoder::ZBarcode_Create()
zint_symbol[:symbology] = 57
p "has zint_symbol a valid id? -> " + (MaxiCodeEncoder::ZBarcode_ValidID(zint_symbol[:symbology]) == 1).to_s


# struct zint_symbol {
  # 	int symbology;
  # 	int height;
  # 	int whitespace_width;
  # 	int border_width;
  # 	int output_options;
  # 	char fgcolour[10];
  # 	char bgcolour[10];
  # 	char outfile[256];
  # 	float scale;
  # 	int option_1;
  # 	int option_2;
  # 	int option_3;
  # 	int show_hrt;
  # 	int input_mode;
  # 	unsigned char text[128];
  # 	int rows;
  # 	int width;
  # 	char primary[128];
  # 	unsigned char encoded_data[178][143];
  # 	int row_height[178]; /* Largest symbol is 177x177 QR Code */
  # 	char errtxt[100];
  # 	char *bitmap;
  # 	int bitmap_width;
  # 	int bitmap_height;
  # 	struct zint_render *rendered;
  # };
  #