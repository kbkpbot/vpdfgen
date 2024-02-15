module vpdfgen

#flag @VMODROOT/c/pdfgen.o
#flag -I @VMODROOT/c
#flag -lm
#include "pdfgen.h"

struct PDF_Doc {}

pub struct PDF_Info {
pub mut:
	creator  string // Software used to create the PDF
	producer string // Software used to create the PDF
	title    string // The title of the PDF (typically displayed in the window bar when viewing)
	author   string // Who created the PDF
	subject  string // What is the PDF about
	date     string // The date the PDF was created
}

struct C.pdf_object {}

struct C.bmp_header {}

struct C.jpeg_header {}

struct C.png_header {}

struct C.ppm_header {}

struct C.pdf_info {
mut:
	creator  [64]u8 // Software used to create the PDF
	producer [64]u8 // Software used to create the PDF
	title    [64]u8 // The title of the PDF (typically displayed in the window bar when viewing)
	author   [64]u8 // Who created the PDF
	subject  [64]u8 // What is the PDF about
	date     [64]u8 // The date the PDF was created
}

struct PDF_Page {
	doc  &PDF_Doc
	page &C.pdf_object
}

// PDF_Image_Format enum that declares the different image file formats we currently support.
// Each value has a corresponding header struct used within the format_specific_img_info union
pub enum PDF_Image_Format {
	image_png     = int(1)
	image_jpg
	image_ppm
	image_bmp
	image_unknown
}

// PNG_Color_Type information about color type of PNG format
// As defined by https://www.w3.org/TR/2003/REC-PNG-20031110/#6Colour-values
pub enum PNG_Color_Type {
	png_color_greyscale   = 0 // Greyscale
	png_color_rgb         = 2 // Truecolour
	png_color_indexed     = 3 // Indexed-colour
	png_color_greyscale_a = 4 // Greyscale with alpha
	png_color_rgba        = 6 // Truecolour with alpha
	png_color_invalid     = 255
}

// C.png_header describes the header information extracted from .PNG files
@[packed]
pub struct C.png_header {
pub:
	width     u32 // Width in pixels
	height    u32 // Height in pixels
	bitDepth  u8  // Bit Depth
	colorType u8  // Color type - see PNG_COLOR_xx
	deflate   u8  // Deflate setting
	filtering u8  // Filtering
	interlace u8  // Interlacing
}

// C.bmp_header describes the header information extracted from .BMP files
@[packed]
pub struct C.bmp_header {
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

// C.jpeg_header describes the header information extracted from .JPG files
pub struct C.jpeg_header {
pub:
	ncolours i32 // Number of colours
}

pub enum PPM_Color_Spaces {
	ppm_binary_color_rgb // binary ppm with RGB colors (magic number P5)
	ppm_binary_color_gray // binary ppm with grayscale colors (magic number P6)
}

// C.ppm_header describes the header information extracted from .PPM files
pub struct C.ppm_header {
pub:
	size           usize // Indicate the size of the image data
	data_begin_pos usize // position in the data where the image starts
	color_space    i32   // PPM color space
}

pub union Image_Header {
	bmp  C.bmp_header  // BMP header info
	jpeg C.jpeg_header // JPEG header info
	png  C.png_header  // PNG header info
	ppm  C.ppm_header  // PPM header info
}

// PDF_Img_Info describes the metadata for an arbitrary image
pub struct PDF_Img_Info {
pub:
	image_format PDF_Image_Format // Indicates the image format (IMAGE_PNG, ...)
	width        u32 // Width in pixels
	height       u32 // Height in pixels
	header       Image_Header
}

// C.pdf_path_operation holds information about a path drawing operation
pub struct C.pdf_path_operation {
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

// PDF_Alignment different alignment options for rendering text
pub enum PDF_Alignment {
	pdf_align_left
	pdf_align_right
	pdf_align_center
	pdf_align_justify
	pdf_align_justify_all
	pdf_align_no_write
}

// pdf_inch_to_point convert a value in inches into a number of points
@[inline]
pub fn pdf_inch_to_point(inch f32) f32 {
	return inch * 72.0
}

// pdf_mm_to_point convert a value in milli-meters into a number of points
@[inline]
pub fn pdf_mm_to_point(mm f32) f32 {
	return (mm * 72.0) / 25.4
}

pub const pdf_letter_width = pdf_inch_to_point(8.5) // Point width of a standard US-Letter page
pub const pdf_letter_height = pdf_inch_to_point(11.0) // Point height of a standard US-Letter page
pub const pdf_a4_width = pdf_mm_to_point(210.0) // Point width of a standard A4 page
pub const pdf_a4_height = pdf_mm_to_point(297.0) // Point height of a standard A4 page
pub const pdf_a3_width = pdf_mm_to_point(297.0) // Point width of a standard A3 page
pub const pdf_a3_height = pdf_mm_to_point(420.0) // Point height of a standard A3 page

// pdf_rgb convert three 8-bit RGB values into a single packed 32-bit colour
@[inline]
pub fn pdf_rgb(r u8, g u8, b u8) u32 {
	return u32(r) << 16 | u32(g) << 8 | u32(b)
}

// pdf_argb convert four 8-bit ARGB values into a single packed 32-bit colour
// Alpha value `a` range from 0 (opaque) to 0xff (transparent)
@[inline]
pub fn pdf_argb(a u8, r u8, g u8, b u8) u32 {
	return u32(a) << 24 | u32(r) << 16 | u32(g) << 8 | u32(b)
}

pub const pdf_red = u32(0x00ff0000)
pub const pdf_green = u32(0x0000ff00)
pub const pdf_blue = u32(0x000000ff)
pub const pdf_black = u32(0x00000000)
pub const pdf_white = u32(0x00ffffff)
pub const pdf_transparent = u32(0xff000000)

// PDF_BarCode list of different barcode encodings that are supported
pub enum PDF_BarCode {
	pdf_barcode_128a // Produce code-128A style barcodes
	pdf_barcode_39 // Produce code-39 style barcodes
	pdf_barcode_ean13 // Produce EAN-13 style barcodes
	pdf_barcode_upca // Produce UPC-A style barcodes
	pdf_barcode_ean8 // Produce EAN-8 style barcodes
	pdf_barcode_upce // Produce UPC-E style barcodes
}

fn C.pdf_create(width f32, height f32, info &C.pdf_info) &PDF_Doc
fn C.pdf_destroy(pdf &PDF_Doc)
fn C.pdf_get_err(pdf &PDF_Doc, errval &int) &char
fn C.pdf_clear_err(pdf &PDF_Doc)
fn C.pdf_set_font(pdf &PDF_Doc, font &char) int
fn C.pdf_get_font_text_width(pdf &PDF_Doc, font_name &char, text &char, size f32, text_width &f32) int
fn C.pdf_height(pdf &PDF_Doc) f32
fn C.pdf_width(pdf &PDF_Doc) f32
fn C.pdf_page_height(page &C.pdf_object) f32
fn C.pdf_page_width(page &C.pdf_object) f32
fn C.pdf_append_page(pdf &PDF_Doc) &C.pdf_object
fn C.pdf_get_page(pdf &PDF_Doc, page_number int) &C.pdf_object
fn C.pdf_page_set_size(pdf &PDF_Doc, page &C.pdf_object, width f32, height f32) int
fn C.pdf_save(pdf &PDF_Doc, filename &char) int
fn C.pdf_save_file(pdf &PDF_Doc, fp &C.FILE) int
fn C.pdf_add_text(pdf &PDF_Doc, page &C.pdf_object, text &char, size f32, xoff f32, yoff f32, colour u32) int
fn C.pdf_add_text_rotate(pdf &PDF_Doc, page &C.pdf_object, text &char, size f32, xoff f32, yoff f32, angle f32, colour u32) int
fn C.pdf_add_text_wrap(pdf &PDF_Doc, page &C.pdf_object, text &char, size f32, xoff f32, yoff f32, angle f32, colour u32, wrap_width f32, align int, height &f32) int
fn C.pdf_add_line(pdf &PDF_Doc, page &C.pdf_object, x1 f32, y1 f32, x2 f32, y2 f32, width f32, colour u32) int
fn C.pdf_add_cubic_bezier(pdf &PDF_Doc, page &C.pdf_object, x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, xq2 f32, yq2 f32, width f32, colour u32) int
fn C.pdf_add_quadratic_bezier(pdf &PDF_Doc, page &C.pdf_object, x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, width f32, colour u32) int
fn C.pdf_add_custom_path(pdf &PDF_Doc, page &C.pdf_object, operations &C.pdf_path_operation, operation_count int, stroke_width f32, stroke_colour u32, fill_colour u32) int
fn C.pdf_add_ellipse(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, xradius f32, yradius f32, width f32, colour u32, fill_colour u32) int
fn C.pdf_add_circle(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, radius f32, width f32, colour u32, fill_colour u32) int
fn C.pdf_add_rectangle(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, width f32, height f32, border_width f32, colour u32) int
fn C.pdf_add_filled_rectangle(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, width f32, height f32, border_width f32, colour_fill u32, colour_border u32) int
fn C.pdf_add_polygon(pdf &PDF_Doc, page &C.pdf_object, x &f32, y &f32, count int, border_width f32, colour u32) int
fn C.pdf_add_filled_polygon(pdf &PDF_Doc, page &C.pdf_object, x &f32, y &f32, count int, border_width f32, colour u32) int
fn C.pdf_add_bookmark(pdf &PDF_Doc, page &C.pdf_object, parent int, name &char) int
fn C.pdf_add_link(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, width f32, height f32, target_page &C.pdf_object, target_x f32, target_y f32) int
fn C.pdf_add_barcode(pdf &PDF_Doc, page &C.pdf_object, code int, x f32, y f32, width f32, height f32, string_ &char, colour u32) int
fn C.pdf_add_image_data(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, display_width f32, display_height f32, data &u8, len usize) int
fn C.pdf_add_rgb24(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, display_width f32, display_height f32, data &u8, width u32, height u32) int
fn C.pdf_add_grayscale8(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, display_width f32, display_height f32, data &u8, width u32, height u32) int
fn C.pdf_add_image_file(pdf &PDF_Doc, page &C.pdf_object, x f32, y f32, display_width f32, display_height f32, image_filename &char) int
fn C.pdf_parse_image_header(info &PDF_Img_Info, data &u8, length usize, err_msg &char, err_msg_length usize) int

@[inline]
fn copy_string_to_fixed_array(dest &u8, src string) {
	if src.len > 63 {
		unsafe { vmemcpy(dest, src.str, 63) }
	} else {
		unsafe { vmemcpy(dest, src.str, src.len) }
	}
}

// new_pdf create a new PDF object, with the given page width/height
pub fn new_pdf(width f32, height f32, info PDF_Info) !&PDF_Doc {
	p := &C.pdf_info{}
	copy_string_to_fixed_array(&p.creator[0], info.creator)
	copy_string_to_fixed_array(&p.producer[0], info.producer)
	copy_string_to_fixed_array(&p.title[0], info.title)
	copy_string_to_fixed_array(&p.author[0], info.author)
	copy_string_to_fixed_array(&p.subject[0], info.subject)
	copy_string_to_fixed_array(&p.date[0], info.date)
	ret_val := C.pdf_create(width, height, p)
	if isnil(ret_val) {
		return error('Create new PDF fail')
	}
	return ret_val
}

// destroy destroy the pdf object, and all of its associated memory
pub fn (p &PDF_Doc) destroy() {
	C.pdf_destroy(p)
}

// get_err retrieve the error message if any operation fails
pub fn (p &PDF_Doc) get_err(errval int) string {
	mut errval_copy := errval
	return unsafe { cstring_to_vstring(C.pdf_get_err(p, &errval_copy)) }
}

// clear_err clear the error message
pub fn (p &PDF_Doc) clear_err() {
	C.pdf_clear_err(p)
}

// set_font Sets the font to use for text objects. Default value is Times-Roman if this function is not called
// `font` must be one of the standard PDF fonts:
// Courier, Courier-Bold, Courier-BoldOblique, Courier-Oblique,
// Helvetica, Helvetica-Bold, Helvetica-BoldOblique, Helvetica-Oblique,
// Times-Roman, Times-Bold, Times-Italic, Times-BoldItalic,
// Symbol or ZapfDingbats
pub fn (p &PDF_Doc) set_font(font string) ! {
	ret_val := C.pdf_set_font(p, font.str)
	if ret_val < 0 {
		return error(p.get_err(ret_val))
	}
}

// get_font_text_width calculate the width of a given string in the current font
// `size` is size of the `text`, in points
pub fn (p &PDF_Doc) get_font_text_width(font_name string, text string, size f32) !f32 {
	mut text_width := f32(0)
	ret_val := C.pdf_get_font_text_width(p, font_name.str, text.str, size, &text_width)
	if ret_val < 0 {
		return error(p.get_err(ret_val))
	}
	return text_width
}

// height retrieves a PDF document height(in points)
pub fn (p &PDF_Doc) height() f32 {
	return C.pdf_height(p)
}

// width retrieves a PDF document width(in points)
pub fn (p &PDF_Doc) width() f32 {
	return C.pdf_width(p)
}

// append_page add a new page to the given pdf
pub fn (p &PDF_Doc) append_page() &PDF_Page {
	return &PDF_Page{
		doc: unsafe { p }
		page: C.pdf_append_page(p)
	}
}

// get_page retrieve a page by its number
pub fn (p &PDF_Doc) get_page(page_number int) &PDF_Page {
	return &PDF_Page{
		doc: unsafe { p }
		page: C.pdf_get_page(p, page_number)
	}
}

// save save the given pdf document to the supplied filename
pub fn (p &PDF_Doc) save(filename string) int {
	return C.pdf_save(p, filename.str)
}

// save_file save the given pdf document to the given FILE output
// pub fn (p &PDF_Doc) save_file(fp &C.FILE) int {
//	return C.pdf_save_file(p, fp)
//}

// set_size adjust the width/height(in points) of a specific page
pub fn (p &PDF_Page) set_size(width f32, height f32) ! {
	ret_val := C.pdf_page_set_size(p.doc, p.page, width, height)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_text add a text string to the document
// `size` is point size of the font
pub fn (p &PDF_Page) add_text(text string, size f32, xoff f32, yoff f32, colour u32) ! {
	ret_val := C.pdf_add_text(p.doc, p.page, text.str, size, xoff, yoff, colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_text_rotate add a text string to the document at a rotated angle
// `size` is point size of the font
// `angle` is rotation angle of `text` (in radians)
pub fn (p &PDF_Page) add_text_rotate(text string, size f32, xoff f32, yoff f32, angle f32, colour u32) ! {
	ret_val := C.pdf_add_text_rotate(p.doc, p.page, text.str, size, xoff, yoff, angle,
		colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_text_wrap add a text string to the document, making it wrap if it is too long
// `size` is point size of the font
// return the final height of the wrapped text
pub fn (p &PDF_Page) add_text_wrap(text string, size f32, xoff f32, yoff f32, angle f32, colour u32, wrap_width f32, align PDF_Alignment) !f32 {
	mut height := f32(0)
	ret_val := C.pdf_add_text_wrap(p.doc, p.page, text.str, size, xoff, yoff, angle, colour,
		wrap_width, int(align), &height)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
	return height
}

// add_line add a line to the document
pub fn (p &PDF_Page) add_line(x1 f32, y1 f32, x2 f32, y2 f32, width f32, colour u32) ! {
	ret_val := C.pdf_add_line(p.doc, p.page, x1, y1, x2, y2, width, colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_cubic_bezier add a cubic bezier curve to the document
pub fn (p &PDF_Page) add_cubic_bezier(x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, xq2 f32, yq2 f32, width f32, colour u32) ! {
	ret_val := C.pdf_add_cubic_bezier(p.doc, p.page, x1, y1, x2, y2, xq1, yq1, xq2, yq2,
		width, colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_quadratic_bezier add a quadratic bezier curve to the document
pub fn (p &PDF_Page) add_quadratic_bezier(x1 f32, y1 f32, x2 f32, y2 f32, xq1 f32, yq1 f32, width f32, colour u32) ! {
	ret_val := C.pdf_add_quadratic_bezier(p.doc, p.page, x1, y1, x2, y2, xq1, yq1, width,
		colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_custom_path add a custom path to the document
// `operations` is array of drawing operations
pub fn (p &PDF_Page) add_custom_path(operations []C.pdf_path_operation, stroke_width f32, stroke_colour u32, fill_colour u32) ! {
	ret_val := C.pdf_add_custom_path(p.doc, p.page, operations.data, operations.len, stroke_width,
		stroke_colour, fill_colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_ellipse add an ellipse to the document
pub fn (p &PDF_Page) add_ellipse(x f32, y f32, xradius f32, yradius f32, width f32, colour u32, fill_colour u32) ! {
	ret_val := C.pdf_add_ellipse(p.doc, p.page, x, y, xradius, yradius, width, colour,
		fill_colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_circle add a circle to the document
pub fn (p &PDF_Page) add_circle(x f32, y f32, radius f32, width f32, colour u32, fill_colour u32) ! {
	ret_val := C.pdf_add_circle(p.doc, p.page, x, y, radius, width, colour, fill_colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_rectangle add an outline rectangle to the document
pub fn (p &PDF_Page) add_rectangle(x f32, y f32, width f32, height f32, border_width f32, colour u32) ! {
	ret_val := C.pdf_add_rectangle(p.doc, p.page, x, y, width, height, border_width, colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_filled_rectangle add a filled rectangle to the document
pub fn (p &PDF_Page) add_filled_rectangle(x f32, y f32, width f32, height f32, border_width f32, colour_fill u32, colour_border u32) ! {
	ret_val := C.pdf_add_filled_rectangle(p.doc, p.page, x, y, width, height, border_width,
		colour_fill, colour_border)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_polygon add an outline polygon to the document
pub fn (p &PDF_Page) add_polygon(x []f32, y []f32, border_width f32, colour u32) ! {
	if x.len != y.len {
		return error('@FN x.len != y.len')
	}
	ret_val := C.pdf_add_polygon(p.doc, p.page, x.data, y.data, x.len, border_width, colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_filled_polygon add a filled polygon to the document
pub fn (p &PDF_Page) add_filled_polygon(x []f32, y []f32, border_width f32, colour u32) ! {
	if x.len != y.len {
		return error('@FN x.len != y.len')
	}
	ret_val := C.pdf_add_filled_polygon(p.doc, p.page, x.data, y.data, x.len, border_width,
		colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_bookmark add a bookmark to the document
// `parent` ID of a previously created bookmark that is the parent of this one. -1 if this should be a top-level bookmark
pub fn (p &PDF_Page) add_bookmark(parent int, name string) !int {
	ret_val := C.pdf_add_bookmark(p.doc, p.page, parent, name.str)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
	return ret_val
}

// add_link add a link annotation to the document
pub fn (p &PDF_Page) add_link(x f32, y f32, width f32, height f32, target_page &PDF_Page, target_x f32, target_y f32) ! {
	ret_val := C.pdf_add_link(p.doc, p.page, x, y, width, height, target_page.page, target_x,
		target_y)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_barcode add a barcode to the document
pub fn (p &PDF_Page) add_barcode(code PDF_BarCode, x f32, y f32, width f32, height f32, str string, colour u32) ! {
	ret_val := C.pdf_add_barcode(p.doc, p.page, int(code), x, y, width, height, str.str,
		colour)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_image_data add image data as an image to the document
// `data` must be one of: JPEG, PNG, PPM, PGM or BMP formats
pub fn (p &PDF_Page) add_image_data(x f32, y f32, display_width f32, display_height f32, data []u8) ! {
	ret_val := C.pdf_add_image_data(p.doc, p.page, x, y, display_width, display_height,
		data.data, data.len)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_rgb24 add a raw 24 bit per pixel RGB buffer as an image to the document
// passing 0 for either the display width or height will include the image but not render it visible
// passing a negative number either the display height or width will have the image be resized while keeping the original aspect ratio
pub fn (p &PDF_Page) add_rgb24(x f32, y f32, display_width f32, display_height f32, data []u8, width u32, height u32) ! {
	ret_val := C.pdf_add_rgb24(p.doc, p.page, x, y, display_width, display_height, data.data,
		width, height)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_grayscale8 add a raw 8 bit per pixel grayscale buffer as an image to the document
pub fn (p &PDF_Page) add_grayscale8(x f32, y f32, display_width f32, display_height f32, data []u8, width u32, height u32) ! {
	ret_val := C.pdf_add_grayscale8(p.doc, p.page, x, y, display_width, display_height,
		data.data, width, height)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// add_image_file add an image file as an image to the document
// passing 0 for either the display width or height will include the image but not render it visible
// passing a negative number either the display height or width will have the image be resized while keeping the original aspect ratio
// supports image formats: JPEG, PNG, PPM, PGM & BMP
pub fn (p &PDF_Page) add_image_file(x f32, y f32, display_width f32, display_height f32, image_filename string) ! {
	ret_val := C.pdf_add_image_file(p.doc, p.page, x, y, display_width, display_height,
		image_filename.str)
	if ret_val < 0 {
		return error(p.doc.get_err(ret_val))
	}
}

// height retrieves page height
pub fn (p &PDF_Page) height() f32 {
	return C.pdf_page_height(p.page)
}

// width retrieves page width
pub fn (p &PDF_Page) width() f32 {
	return C.pdf_page_width(p.page)
}

// pdf_parse_image_header parse image data to determine the image type & metadata
pub fn pdf_parse_image_header(data []u8) !&PDF_Img_Info {
	mut err_msg := []u8{len: 1024}
	mut info := &PDF_Img_Info{}
	ret_val := C.pdf_parse_image_header(info, data.data, data.len, err_msg.data, err_msg.len)
	if ret_val < 0 {
		return error(unsafe { tos_clone(&err_msg[0]) })
	}
	return info
}
