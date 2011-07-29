require 'test_helper'
require 'fileutils'
require 'prawn'
require 'prawn/layout'


class PrawnMaxiCodeOutputterTest < Barby::TestCase

  before do
    load_outputter('prawn')
    @barcode = MaxiCode.new("data are still hardcoded in the class")
    @outputter = PrawnOutputter.new(@barcode)
  end

  it "should produce a maxi code" do

    maxiCode_height = 85.1
    maxiCode_width = 85

    @pdf = Prawn::Document.new(:page_size => [286.299212598425, 601.6], :margin => [10, 10, 10, 10])
    @pdf.bounding_box([@pdf.bounds.left, @pdf.bounds.top - 14.1*10.2], :width => maxiCode_width, :height => maxiCode_height) do
      @barcode.annotate_pdf(@pdf, {:height => maxiCode_height, :xdim => 1, :x => 1, :y => 1})
      @pdf.stroke_bounds
    end

    FileUtils.mkdir('tmp') unless File.exist?('tmp')
    File.open("tmp/out.pdf", 'w') { |f| f.write(@pdf.render) }
  end


end
