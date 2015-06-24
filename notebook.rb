require 'prawn'

@pdf = Prawn::Document.new

def cover title
  cover_font = "Helvetica"
  @pdf.stroke_bounds
  @pdf.move_down 170
  @pdf.image "WhitbyWordmarkBlueGeneric.jpg",
    :position  => :center,
    :scale => 0.8
  @pdf.formatted_text_box([ {:text => "#{title}",
                             :font => "#{cover_font}",
                             :styles => [:bold],
                             :size => 25}
  ], :align => :center, :at => [0,400])
  @pdf.formatted_text_box([ {:text => "2015 - 2016",
                             :font => "#{cover_font}",
                             :styles => [:bold],
                             :size => 22}
  ], :align => :center, :at => [0,370])
  @pdf.formatted_text_box([ {:text => "Name: _________________",
                             :font => "#{cover_font}",
                             :styles => [:bold],
                             :size => 22}
  ], :align => :center, :at => [0,175])
  @pdf.formatted_text_box([ {:text => "Class: _________________",
                             :font => "#{cover_font}",
                             :styles => [:bold],
                             :size => 22}
  ], :align => :center, :at => [0,140])
  @pdf.image "rn.png",
    :at => [220,320],
    :scale => 0.4
end

def inside_cover
  @pdf.start_new_page
  @pdf.move_down 100
  @pdf.image "HWT_Alphabet.png",
    :position => :center,
    :scale => 0.3
end

def page_content line_spacing,
  num_of_lines,
  top_margin,
  vertical_line_start
  @pdf.start_new_page( :bottom_margin  => 0, :left_margin  => 0,
                      :right_margin => 0)
  @pdf.move_down top_margin
  @pdf.stroke do
    @pdf.stroke_color "ff0000"
    @pdf.line_width 0.8
    @pdf.vertical_line 0, vertical_line_start, :at => 65
  end
  num_of_lines.times do
    @pdf.stroke do
      @pdf.line_width 0.4
      @pdf.stroke_color "0000ff"
      @pdf.horizontal_line 0, 650
      @pdf.move_down line_spacing
      @pdf.horizontal_line 0, 650
      @pdf.move_down 43
    end
  end

end
def body line_spacing,notebook_type
  100.times do |page|
    if notebook_type == 'LE'
      if (page + 1).odd?
        page_content line_spacing,7,350,406
        @pdf.stroke do
          @pdf.rectangle [10,782], 592,340
        end
      else
        page_content line_spacing,12,60,1000
      end
    else
        page_content line_spacing,12,60,1000
    end
    @pdf.formatted_text_box([ {:text => "Date: _________________",
                               :font => "Courier",
                               :size => 9}
    ], :at => [450,762])
    @pdf.formatted_text_box([ {:text => "#{page + 1}",
                               :font => "Courier",
                               :size => 9}
    ], :align => :center, :at => [0,20])
  end
end
cover 'LE Notebook'
inside_cover
body 13,'LE'
@pdf.render_file 'LE Notebook.pdf'
