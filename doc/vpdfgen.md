# module vpdfgen
# vpdfgen
## Description
A [vlang](https://github.com/vlang/v) PDFGen module

This is an effort port [PDFGen](https://github.com/AndreRenaud/PDFGen) to vlang.

Please check [doc](https://github.com/kbkpbot/vpdfgen/doc/vpdfgen.md) for more API description.

## Install


```sh
v install --git https://github.com/kbkpbot/vpdfgen.git
```


## Simple Usage

```v
module main
import vpdfgen

fn main() {
info := &vpdfgen.PDF_Info {
creator : 'My software'
producer : 'My software'
title : 'My document'
author : 'kbkpbot'
subject : 'My subject'
date : 'Today'
}
pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
pdf.set_font('Times-Roman')!
page := pdf.append_page()
page.add_text('This is text', 12, 50, 20, vpdfgen.pdf_black)!
page.add_line(50, 24, 150, 24, 3, vpdfgen.pdf_black)!

pdf.save('output.pdf')
pdf.destroy()
}

```

## TODO

- Add TTF font support;



## Contents
- [Constants](#Constants)
- [new_pdf](#new_pdf)
- [pdf_argb](#pdf_argb)
- [pdf_inch_to_point](#pdf_inch_to_point)
- [pdf_mm_to_point](#pdf_mm_to_point)
- [pdf_parse_image_header](#pdf_parse_image_header)
- [pdf_rgb](#pdf_rgb)
- [PDF_Doc](#PDF_Doc)
  - [destroy](#destroy)
  - [get_err](#get_err)
  - [clear_err](#clear_err)
  - [set_font](#set_font)
  - [get_font_text_width](#get_font_text_width)
  - [height](#height)
  - [width](#width)
  - [append_page](#append_page)
  - [get_page](#get_page)
  - [save](#save)
- [PDF_Page](#PDF_Page)
  - [set_size](#set_size)
  - [add_text](#add_text)
  - [add_text_rotate](#add_text_rotate)
  - [add_text_wrap](#add_text_wrap)
  - [add_line](#add_line)
  - [add_cubic_bezier](#add_cubic_bezier)
  - [add_quadratic_bezier](#add_quadratic_bezier)
  - [add_custom_path](#add_custom_path)
  - [add_ellipse](#add_ellipse)
  - [add_circle](#add_circle)
  - [add_rectangle](#add_rectangle)
  - [add_filled_rectangle](#add_filled_rectangle)
  - [add_polygon](#add_polygon)
  - [add_filled_polygon](#add_filled_polygon)
  - [add_bookmark](#add_bookmark)
  - [add_link](#add_link)
  - [add_barcode](#add_barcode)
  - [add_image_data](#add_image_data)
  - [add_rgb24](#add_rgb24)
  - [add_grayscale8](#add_grayscale8)
  - [add_image_file](#add_image_file)
  - [height](#height)
  - [width](#width)
- [PDF_Alignment](#PDF_Alignment)
- [PDF_BarCode](#PDF_BarCode)
- [PDF_Image_Format](#PDF_Image_Format)
- [PNG_Color_Type](#PNG_Color_Type)
- [PPM_Color_Spaces](#PPM_Color_Spaces)
- [C.bmp_header](#C.bmp_header)
- [C.jpeg_header](#C.jpeg_header)
- [C.pdf_path_operation](#C.pdf_path_operation)
- [C.png_header](#C.png_header)
- [C.ppm_header](#C.ppm_header)
- [Image_Header](#Image_Header)
- [PDF_Img_Info](#PDF_Img_Info)
- [PDF_Info](#PDF_Info)

## Constants
[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

[[Return to contents]](#Contents)

## new_pdf
```v
fn new_pdf(width f32, height f32, info PDF_Info) !&PDF_Doc
```
new_pdf create a new PDF object, with the given page width/height

[[Return to contents]](#Contents)

## pdf_argb
```v
fn pdf_argb(a u8, r u8, g u8, b u8) u32
```
pdf_argb convert four 8-bit ARGB values into a single packed 32-bit colour Alpha value `a` range from 0 (opaque) to 0xff (transparent)

[[Return to contents]](#Contents)

## pdf_inch_to_point
```v
fn pdf_inch_to_point(inch f32) f32
```
pdf_inch_to_point convert a value in inches into a number of points

[[Return to contents]](#Contents)

## pdf_mm_to_point
```v
fn pdf_mm_to_point(mm f32) f32
```
pdf_mm_to_point convert a value in milli-meters into a number of points

[[Return to contents]](#Contents)

## pdf_parse_image_header
```v
fn pdf_parse_image_header(data []u8) !&PDF_Img_Info
```
pdf_parse_image_header parse image data to determine the image type & metadata

[[Return to contents]](#Contents)

## pdf_rgb
```v
fn pdf_rgb(r u8, g u8, b u8) u32
```
pdf_rgb convert three 8-bit RGB values into a single packed 32-bit colour

[[Return to contents]](#Contents)

## PDF_Doc
## destroy
```v
fn (p &PDF_Doc) destroy()
```
destroy destroy the pdf object, and all of its associated memory

[[Return to contents]](#Contents)

## get_err
```v
fn (p &PDF_Doc) get_err(errval int) string
```
get_err retrieve the error message if any operation fails

[[Return to contents]](#Contents)

## clear_err
```v
fn (p &PDF_Doc) clear_err()
```
clear_err clear the error message

[[Return to contents]](#Contents)

## set_font
```v
fn (p &PDF_Doc) set_font(font string) !
```
set_font Sets the font to use for text objects. Default value is Times-Roman if this function is not called `font` must be one of the standard PDF fonts: Courier, Courier-Bold, Courier-BoldOblique, Courier-Oblique, Helvetica, Helvetica-Bold, Helvetica-BoldOblique, Helvetica-Oblique, Times-Roman, Times-Bold, Times-Italic, Times-BoldItalic, Symbol or ZapfDingbats

[[Return to contents]](#Contents)

## get_font_text_width
```v
fn (p &PDF_Doc) get_font_text_width(font_name string, text string, size f32) !f32
```
get_font_text_width calculate the width of a given string in the current font `size` is size of the `text`, in points

[[Return to contents]](#Contents)

## height
```v
fn (p &PDF_Doc) height() f32
```
height retrieves a PDF document height(in points)

[[Return to contents]](#Contents)

## width
```v
fn (p &PDF_Doc) width() f32
```
width retrieves a PDF document width(in points)

[[Return to contents]](#Contents)

## append_page
```v
fn (p &PDF_Doc) append_page() &PDF_Page
```
append_page add a new page to the given pdf

[[Return to contents]](#Contents)

## get_page
```v
fn (p &PDF_Doc) get_page(page_number int) &PDF_Page
```
get_page retrieve a page by its number

[[Return to contents]](#Contents)

## save
```v
fn (p &PDF_Doc) save(filename string) int
```
save save the given pdf document to the supplied filename

[[Return to contents]](#Contents)

## PDF_Page
## set_size
```v
fn (p &PDF_Page) set_size(width f32, height f32) !
```
set_size adjust the width/height(in points) of a specific page

[[Return to contents]](#Contents)

## add_text
```v
fn (p &PDF_Page) add_text(text string, size f32, xoff f32, yoff f32, colour u32) !
```
add_text add a text string to the document `size` is point size of the font

[[Return to contents]](#Contents)

## add_text_rotate
```v
fn (p &PDF_Page) add_text_rotate(text string, size f32, xoff f32, yoff f32, angle f32, colour u32) !
```
add_text_rotate add a text string to the document at a rotated angle `size` is point size of the font `angle` is rotation angle of `text` (in radians)

[[Return to contents]](#Contents)

## add_text_wrap
```v
fn (p &PDF_Page) add_text_wrap(text string, size f32, xoff f32, yoff f32, angle f32, colour u32, wrap_width f32, align PDF_Alignment) !f32
```
add_text_wrap add a text string to the document, making it wrap if it is too long `size` is point size of the font return the final height of the wrapped text

[[Return to contents]](#Contents)

## add_line
```v
fn (p &PDF_Page) add_line(x1 f32, y1 f32, x2 f32, y2 f32, width f32, colour u32) !
```
add_line add a line to the document

[[Return to contents]](#Contents)

## add_cubic_bezier
```v
fn (p &PDF_Page) add_cubic_bezier(x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, xq2 f32, yq2 f32, width f32, colour u32) !
```
add_cubic_bezier add a cubic bezier curve to the document

[[Return to contents]](#Contents)

## add_quadratic_bezier
```v
fn (p &PDF_Page) add_quadratic_bezier(x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, width f32, colour u32) !
```
add_quadratic_bezier add a quadratic bezier curve to the document

[[Return to contents]](#Contents)

## add_custom_path
```v
fn (p &PDF_Page) add_custom_path(operations []C.pdf_path_operation, stroke_width f32, stroke_colour u32, fill_colour u32) !
```
add_custom_path add a custom path to the document `operations` is array of drawing operations

[[Return to contents]](#Contents)

## add_ellipse
```v
fn (p &PDF_Page) add_ellipse(x f32, y f32, xradius f32, yradius f32, width f32, colour u32, fill_colour u32) !
```
add_ellipse add an ellipse to the document

[[Return to contents]](#Contents)

## add_circle
```v
fn (p &PDF_Page) add_circle(x f32, y f32, radius f32, width f32, colour u32, fill_colour u32) !
```
add_circle add a circle to the document

[[Return to contents]](#Contents)

## add_rectangle
```v
fn (p &PDF_Page) add_rectangle(x f32, y f32, width f32, height f32, border_width f32, colour u32) !
```
add_rectangle add an outline rectangle to the document

[[Return to contents]](#Contents)

## add_filled_rectangle
```v
fn (p &PDF_Page) add_filled_rectangle(x f32, y f32, width f32, height f32, border_width f32, colour_fill u32, colour_border u32) !
```
add_filled_rectangle add a filled rectangle to the document

[[Return to contents]](#Contents)

## add_polygon
```v
fn (p &PDF_Page) add_polygon(x []f32, y []f32, border_width f32, colour u32) !
```
add_polygon add an outline polygon to the document

[[Return to contents]](#Contents)

## add_filled_polygon
```v
fn (p &PDF_Page) add_filled_polygon(x []f32, y []f32, border_width f32, colour u32) !
```
add_filled_polygon add a filled polygon to the document

[[Return to contents]](#Contents)

## add_bookmark
```v
fn (p &PDF_Page) add_bookmark(parent int, name string) !int
```
add_bookmark add a bookmark to the document `parent` ID of a previously created bookmark that is the parent of this one. -1 if this should be a top-level bookmark

[[Return to contents]](#Contents)

## add_link
```v
fn (p &PDF_Page) add_link(x f32, y f32, width f32, height f32, target_page &PDF_Page, target_x f32, target_y f32) !
```
add_link add a link annotation to the document

[[Return to contents]](#Contents)

## add_barcode
```v
fn (p &PDF_Page) add_barcode(code PDF_BarCode, x f32, y f32, width f32, height f32, str string, colour u32) !
```
add_barcode add a barcode to the document

[[Return to contents]](#Contents)

## add_image_data
```v
fn (p &PDF_Page) add_image_data(x f32, y f32, display_width f32, display_height f32, data []u8) !
```
add_image_data add image data as an image to the document `data` must be one of: JPEG, PNG, PPM, PGM or BMP formats

[[Return to contents]](#Contents)

## add_rgb24
```v
fn (p &PDF_Page) add_rgb24(x f32, y f32, display_width f32, display_height f32, data []u8, width u32, height u32) !
```
add_rgb24 add a raw 24 bit per pixel RGB buffer as an image to the document passing 0 for either the display width or height will include the image but not render it visible passing a negative number either the display height or width will have the image be resized while keeping the original aspect ratio

[[Return to contents]](#Contents)

## add_grayscale8
```v
fn (p &PDF_Page) add_grayscale8(x f32, y f32, display_width f32, display_height f32, data []u8, width u32, height u32) !
```
add_grayscale8 add a raw 8 bit per pixel grayscale buffer as an image to the document

[[Return to contents]](#Contents)

## add_image_file
```v
fn (p &PDF_Page) add_image_file(x f32, y f32, display_width f32, display_height f32, image_filename string) !
```
add_image_file add an image file as an image to the document passing 0 for either the display width or height will include the image but not render it visible passing a negative number either the display height or width will have the image be resized while keeping the original aspect ratio supports image formats: JPEG, PNG, PPM, PGM & BMP

[[Return to contents]](#Contents)

## height
```v
fn (p &PDF_Page) height() f32
```
height retrieves page height

[[Return to contents]](#Contents)

## width
```v
fn (p &PDF_Page) width() f32
```
width retrieves page width

[[Return to contents]](#Contents)

## PDF_Alignment
```v
enum PDF_Alignment {
	pdf_align_left
	pdf_align_right
	pdf_align_center
	pdf_align_justify
	pdf_align_justify_all
	pdf_align_no_write
}
```
PDF_Alignment different alignment options for rendering text

[[Return to contents]](#Contents)

## PDF_BarCode
```v
enum PDF_BarCode {
	pdf_barcode_128a // Produce code-128A style barcodes
	pdf_barcode_39 // Produce code-39 style barcodes
	pdf_barcode_ean13 // Produce EAN-13 style barcodes
	pdf_barcode_upca // Produce UPC-A style barcodes
	pdf_barcode_ean8 // Produce EAN-8 style barcodes
	pdf_barcode_upce // Produce UPC-E style barcodes
}
```
PDF_BarCode list of different barcode encodings that are supported

[[Return to contents]](#Contents)

## PDF_Image_Format
```v
enum PDF_Image_Format {
	image_png     = int(1)
	image_jpg
	image_ppm
	image_bmp
	image_unknown
}
```
PDF_Image_Format enum that declares the different image file formats we currently support. Each value has a corresponding header struct used within the format_specific_img_info union

[[Return to contents]](#Contents)

## PNG_Color_Type
```v
enum PNG_Color_Type {
	png_color_greyscale   = 0 // Greyscale
	png_color_rgb         = 2 // Truecolour
	png_color_indexed     = 3 // Indexed-colour
	png_color_greyscale_a = 4 // Greyscale with alpha
	png_color_rgba        = 6 // Truecolour with alpha
	png_color_invalid     = 255
}
```
PNG_Color_Type information about color type of PNG format As defined by https://www.w3.org/TR/2003/REC-PNG-20031110/#6Colour-values

[[Return to contents]](#Contents)

## PPM_Color_Spaces
[[Return to contents]](#Contents)

## C.bmp_header
```v
struct C.bmp_header {
pub:
	bfSize        u32 // size of BMP in bytes
	bfReserved1   u16 // ignore!
	bfReserved2   u16 // ignore!
	bfOffBits     u32 // Offset to BMP data
	biSize        u32 // Size of this header (40)
	biWidth       i32 // Width in pixels
	biHeight      i32 // Height in pixels
	biPlanes      u16 // Number of colour planes - must be 1
	biBitCount    u16 // Bits Per Pixel
	biCompression u32 // Compression Method
}
```
C.bmp_header describes the header information extracted from .BMP files

[[Return to contents]](#Contents)

## C.jpeg_header
```v
struct C.jpeg_header {
pub:
	ncolours i32 // Number of colours
}
```
C.jpeg_header describes the header information extracted from .JPG files

[[Return to contents]](#Contents)

## C.pdf_path_operation
```v
struct C.pdf_path_operation {
	op u8 // Operation command. Possible operators are: m = move to, l =
	// line to, c = cubic bezier curve with two control points, v =
	// cubic bezier curve with one control point fixed at first
	// point, y = cubic bezier curve with one control point fixed
	// at second point, h = close path
	x1 f32 // X offset of the first point. Used with: m, l, c, v, y
	y1 f32 // Y offset of the first point. Used with: m, l, c, v, y
	x2 f32 // X offset of the second point. Used with: c, v, y
	y2 f32 // Y offset of the second point. Used with: c, v, y
	x3 f32 // X offset of the third point. Used with: c
	y3 f32 // Y offset of the third point. Used with: c
}
```
C.pdf_path_operation holds information about a path drawing operation

[[Return to contents]](#Contents)

## C.png_header
```v
struct C.png_header {
pub:
	width     u32 // Width in pixels
	height    u32 // Height in pixels
	bitDepth  u8  // Bit Depth
	colorType u8  // Color type - see PNG_COLOR_xx
	deflate   u8  // Deflate setting
	filtering u8  // Filtering
	interlace u8  // Interlacing
}
```
C.png_header describes the header information extracted from .PNG files

[[Return to contents]](#Contents)

## C.ppm_header
```v
struct C.ppm_header {
pub:
	size           usize // Indicate the size of the image data
	data_begin_pos usize // position in the data where the image starts
	color_space    i32   // PPM color space
}
```
C.ppm_header describes the header information extracted from .PPM files

[[Return to contents]](#Contents)

## Image_Header
[[Return to contents]](#Contents)

## PDF_Img_Info
```v
struct PDF_Img_Info {
pub:
	image_format PDF_Image_Format // Indicates the image format (IMAGE_PNG, ...)
	width        u32 // Width in pixels
	height       u32 // Height in pixels
	header       Image_Header
}
```
PDF_Img_Info describes the metadata for an arbitrary image

[[Return to contents]](#Contents)

## PDF_Info
[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 15 Feb 2024 23:15:38
