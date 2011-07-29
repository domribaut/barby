require 'barby/outputter'

module Barby

  #Outputs an ASCII representation of the barcode. This is mostly useful for printing
  #the barcode directly to the terminal for testing.
  #
  #Registers to_ascii
  class AsciiOutputter < Outputter

    register :to_ascii


    def to_ascii(opts={})
      default_opts = {:height => 10, :xdim => 1, :bar => '#', :space => ' '}
      default_opts.update(:height => 1, :bar => ' X ', :space => '   ') if barcode.two_dimensional?
      default_opts.update(:height => 1, :bar => ' H ', :nil_char => 'O') if barcode.maxi_code?
      opts = default_opts.merge(opts)

      if barcode.two_dimensional?
        booleans.map {|bools|  line_to_ascii(bools, opts)}.join("\n")
      else
        line_to_ascii(booleans, opts)
      end
    end


  private

    def line_to_ascii(booleans, opts)
      Array.new(
          opts[:height],
          booleans.map do |b|
            if b == nil
              opts[:nil_char] * opts[:xdim]
            else
              (b ? opts[:bar] : opts[:space]) * opts[:xdim]
            end
          end.join
      ).join("\n")
    end


  end

end
