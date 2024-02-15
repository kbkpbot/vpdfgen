module main

import vpdfgen

const m_pi = 3.14159265358979323846
const data_rgb = [u8(0x00), 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00]

fn main() {
	info := &vpdfgen.PDF_Info{
		creator: 'My software'
		producer: 'My software'
		title: 'My document'
		author: 'kbkpbot'
		subject: 'My subject'
		date: 'Today'
	}
	pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
	assert pdf.width() == vpdfgen.pdf_a4_width && pdf.height() == vpdfgen.pdf_a4_height, 'PDF Size mismatch'
	pdf.get_font_text_width('Times-BoldItalic', 'foo', 14)!

	pdf.set_font('Times-BoldItalic')!

	pdf.append_page()
	first_page := pdf.get_page(1)

	mut height := first_page.add_text_wrap('This is a great big long string that I hope will wrap properly 
        around several lines.\nThere are some odd length 
        linesthatincludelongwords to check the justification. 
        I have put some embedded line breaks in to 
        see how it copes with them. Hopefully it all works properly.\n\n\n
        We even include multiple breaks\n
        And special stuff €ÜŽžŠšÁ that áüöä should ÄÜÖß— “”‘’ break\n
        ————————————————————————————————————————————————\n
        thisisanenourmouswordthatwillneverfitandwillhavetobecut',
		16, 60, 800, 0, vpdfgen.pdf_rgb(0, 0, 0), 300, .pdf_align_justify)!
	first_page.add_rectangle(58, 800 + 16, 304, -height, 2, vpdfgen.pdf_rgb(0, 0, 0))!
	first_page.add_image_file(10, 10, 20, 30, 'data/teapot.ppm')!
	first_page.add_image_file(50, 10, 30, 30, 'data/coal.png')!
	first_page.add_image_file(100, 10, 30, 30, 'data/bee.bmp')!
	first_page.add_image_file(150, 10, 30, 30, 'data/bee-32-flip.bmp')!

	first_page.add_image_file(150, 50, 50, 150, 'data/grey.jpg')!
	first_page.add_image_file(200, 50, 50, -1, 'data/bee.pgm')!
	first_page.add_image_file(400, 100, 100, 100, 'data/grey.png')!
	first_page.add_image_file(400, 210, 100, 100, 'data/indexed.png')!

	// first_page.add_image_data(100, 500, 50, 150, data_penguin_jpg)!

	first_page.add_text('Page One', 10, 20, 30, vpdfgen.pdf_rgb(0xff, 0, 0))!
	first_page.add_text('PjGQji', 18, 20, 130, vpdfgen.pdf_rgb(0, 0xff, 0xff))!
	first_page.add_line(10, 24, 100, 24, 4, vpdfgen.pdf_rgb(0xff, 0, 0))!
	first_page.add_cubic_bezier(10, 100, 150, 100, 20, 30, 60, 30, 4, vpdfgen.pdf_rgb(0,
		0xff, 0))!
	first_page.add_quadratic_bezier(10, 140, 150, 140, 50, 160, 4, vpdfgen.pdf_rgb(0,
		0, 0xff))!
	operations := [
		C.pdf_path_operation{
			op: `m`
			x1: 100
			y1: 100
		},
		C.pdf_path_operation{
			op: `l`
			x1: 130
			y1: 100
		},
		C.pdf_path_operation{
			op: `c`
			x1: 150
			y1: 150
			x2: 100
			y2: 100
			x3: 130
			y3: 130
		},
		C.pdf_path_operation{
			op: `l`
			x1: 150
			y1: 120
		},
		C.pdf_path_operation{
			op: `h`
		},
	]
	first_page.add_custom_path(operations, 1, vpdfgen.pdf_rgb(0xff, 0, 0), vpdfgen.pdf_argb(0x80,
		0xff, 0, 0))!
	first_page.add_circle(100, 240, 50, 5, vpdfgen.pdf_rgb(0xff, 0, 0), vpdfgen.pdf_transparent)!
	first_page.add_ellipse(100, 240, 40, 30, 2, vpdfgen.pdf_rgb(0xff, 0xff, 0), vpdfgen.pdf_rgb(0,
		0, 0))!
	first_page.add_rectangle(150, 150, 100, 100, 4, vpdfgen.pdf_rgb(0, 0, 0xff))!
	first_page.add_filled_rectangle(150, 450, 100, 100, 4, vpdfgen.pdf_rgb(0, 0xff, 0),
		vpdfgen.pdf_transparent)!
	first_page.add_text_rotate('This should be transparent', 20, 160, 500, m_pi / 4, vpdfgen.pdf_argb(0x80,
		0, 0, 0))!

	p1x := [f32(200), 200, 300, 300]
	p1y := [f32(200), 300, 200, 300]
	first_page.add_polygon(p1x, p1y, 4, vpdfgen.pdf_rgb(0xaa, 0xff, 0xee))!
	p2x := [f32(400), 400, 500, 500]
	p2y := [f32(400), 500, 400, 500]
	first_page.add_filled_polygon(p2x, p2y, 4, vpdfgen.pdf_rgb(0xff, 0x77, 0x77))!
	first_page.add_text('', 20, 20, 30, vpdfgen.pdf_rgb(0, 0, 0))!
	first_page.add_text('Date (YYYY-MM-DD):', 20, 220, 30, vpdfgen.pdf_rgb(0, 0, 0))!

	first_page.add_bookmark(-1, 'First page')!

	pdf.append_page()
	second_page := pdf.get_page(2)

	second_page.add_text('Page Two', 10, 20, 30, vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('This is some weird text () \\ # : - Wi-Fi 27°C', 10, 50, 60,
		vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('Control characters ( ) < > [ ] { } / % \n \r \t \b \f ending',
		10, 50, 45, vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('Special characters: €ÜŽžŠšÁáüöäÄÜÖß—“”‘’Æ',
		10, 50, 15, vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('This one has a new line in it\nThere it was', 10, 50, 80, vpdfgen.pdf_rgb(0,
		0, 0))!
	second_page.add_text('This is a really long line that will go off the edge of the screen, 
        because it is so long. I like long text. The quick brown fox jumped 
        over the lazy dog. The quick brown fox jumped over the lazy dog',
		10, 100, 100, vpdfgen.pdf_rgb(0, 0, 0))!
	pdf.set_font('Helvetica-Bold')!
	second_page.add_text('This is a really long line that will go off the edge of the screen, 
        because it is so long. I like long text. The quick brown fox jumped 
        over the lazy dog. The quick brown fox jumped over the lazy dog',
		10, 100, 130, vpdfgen.pdf_rgb(0, 0, 0))!
	pdf.set_font('ZapfDingbats')!
	second_page.add_text('This is a really long line that will go off the edge of the screen, 
        because it is so long. I like long text. The quick brown fox jumped 
        over the lazy dog. The quick brown fox jumped over the lazy dog',
		10, 100, 150, vpdfgen.pdf_rgb(0, 0, 0))!

	pdf.set_font('Courier-Bold')!
	second_page.add_text('(5.6.5) RS232 shutdown', 8, 317, 546, vpdfgen.pdf_rgb(0, 0,
		0))!
	second_page.add_text('', 8, 437, 546, vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('Pass', 8, 567, 556, vpdfgen.pdf_rgb(0, 0, 0))!
	second_page.add_text('(5.6.3) RS485 pins', 8, 317, 556, vpdfgen.pdf_rgb(0, 0, 0))!

	mut bm := second_page.add_bookmark(-1, 'Another Page')!
	bm = second_page.add_bookmark(bm, 'Another Page again')!
	second_page.add_bookmark(bm, 'A child page')!
	second_page.add_bookmark(bm, 'Another child page')!
	second_page.add_bookmark(-1, 'Top level again')!
	third_page := pdf.append_page()

	pdf.set_font('Times-Roman')!
	for i in 0 .. 3000 {
		xpos := (i / 100) * f32(40.0)
		ypos := (i % 100) * f32(10.0)
		third_page.add_text('Text blob', 8, xpos, ypos, vpdfgen.pdf_rgb(i, (i * 4) & 0xff,
			(i * 8) & 0xff))!
	}

	page := pdf.append_page()

	assert page.width() == vpdfgen.pdf_a4_width && page.height() == vpdfgen.pdf_a4_height, 'PDF Size mismatch'

	page.add_barcode(.pdf_barcode_39, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(240),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(20), 'CODE39', vpdfgen.pdf_rgb(0,
		0, 0))!

	page.add_barcode(.pdf_barcode_128a, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(210),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(20), 'Code128', vpdfgen.pdf_rgb(0,
		0, 0))!

	page.add_text_wrap('EAN13 Barcode', 10, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(155),
		0, vpdfgen.pdf_rgb(0, 0, 0), vpdfgen.pdf_mm_to_point(60), .pdf_align_center)!
	page.add_rectangle(vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(160), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(40), 1, vpdfgen.pdf_rgb(0xff, 0, 0xff))!
	page.add_barcode(.pdf_barcode_ean13, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(160),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(40), '4003994155486', vpdfgen.pdf_black)!
	page.add_text_wrap('UPCA Barcode', 10, vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(155),
		0, vpdfgen.pdf_rgb(0, 0, 0), vpdfgen.pdf_mm_to_point(60), .pdf_align_center)!
	page.add_rectangle(vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(160), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(80), 1, vpdfgen.pdf_rgb(0, 0, 0xff))!
	page.add_barcode(.pdf_barcode_upca, vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(160),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(80), '003994155480', vpdfgen.pdf_black)!

	page.add_text_wrap('EAN8 Barcode', 10, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(55),
		0, vpdfgen.pdf_rgb(0, 0, 0), vpdfgen.pdf_mm_to_point(60), .pdf_align_center)!
	page.add_rectangle(vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(40), 1, vpdfgen.pdf_rgb(0, 0xff, 0xff))!
	page.add_barcode(.pdf_barcode_ean8, vpdfgen.pdf_mm_to_point(20), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(40), '95012346', vpdfgen.pdf_black)!
	page.add_text_wrap('UPCE Barcode', 10, vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(55),
		0, vpdfgen.pdf_rgb(0, 0, 0), vpdfgen.pdf_mm_to_point(60), .pdf_align_center)!
	page.add_rectangle(vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(80), 1, vpdfgen.pdf_rgb(0, 0xff, 0))!
	page.add_barcode(.pdf_barcode_upce, vpdfgen.pdf_mm_to_point(100), vpdfgen.pdf_mm_to_point(60),
		vpdfgen.pdf_mm_to_point(60), vpdfgen.pdf_mm_to_point(80), '012345000058', vpdfgen.pdf_black)!

	a3_page := pdf.append_page()
	a3_page.set_size(vpdfgen.pdf_a3_height, vpdfgen.pdf_a3_width)!
	a3_page.add_bookmark(-1, 'Last Page')!

	a3_page.add_text('This is an A3 landscape page', 10, 20, 30, vpdfgen.pdf_rgb(0xff,
		0, 0))!
	width := pdf.get_font_text_width('Times-Roman', 'This is an A3 landscape page', 10)!
	if width == 0 {
		a3_page.add_link(20, 30, width, 10, first_page, 0, first_page.height() / 2)!
	}
	a3_page.add_rgb24(72, 72, 288, 144, data_rgb, 16, 8)!

	pdf.save('main.pdf')
	pdf.destroy()
}
