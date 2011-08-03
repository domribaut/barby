require 'barby/outputter'

module Barby

  #Outputs an ASCII representation of the barcode. This is mostly useful for printing
  #the barcode directly to the terminal for testing.
  #
  #Registers to_ascii
  class AsciiOutputter < Outputter

    register :to_ascii

    def booleans
      if barcode.maxi_code?
        inject_bull_eye(super)
      end
    end

    def to_ascii(opts={})
      default_opts = {:height => 10, :xdim => 1, :bar => '#', :space => ' '}
      default_opts.update(:height => 1, :bar => ' X ', :space => '   ') if barcode.two_dimensional?
      default_opts.update(:height => 1, :bar => ' H ', :nil_char => ' O ', :space => '   ') if barcode.maxi_code?
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

    def inject_bull_eye(bool_array)
      (12..15).each { |col| bool_array[11][col]=nil }

      bool_array[12][11]=nil
      bool_array[12][16]=nil

      bool_array[13][10]=nil
      (12..15).each { |col| bool_array[13][col]=nil }
      bool_array[13][17]=nil

      bool_array[14][11]=nil
      (13..14).each { |col| bool_array[14][col]=nil }
      bool_array[14][16]=nil

      (15..16).each do |row|
        bool_array[row][10]=nil
        bool_array[row][12]=nil
        bool_array[row][15]=nil
        bool_array[row][17]=nil
      end

      bool_array[17][11]=nil
      (13..14).each { |col| bool_array[17][col]=nil }
      bool_array[17][16]=nil

      (14..17).each {|row| bool_array[row][9]=nil}
      (14..17).each {|row| bool_array[row][18]=nil}

      bool_array[18][10]=nil
      (12..15).each { |col| bool_array[18][col]=nil }
      bool_array[18][17]=nil

      bool_array[19][11]=nil
      bool_array[19][16]=nil

      (12..15).each { |col| bool_array[20][col]=nil }

      bool_array
    end


  end

end
