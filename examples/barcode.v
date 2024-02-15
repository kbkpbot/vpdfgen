module main

import vpdfgen

fn main() {
	info := &vpdfgen.PDF_Info{}
	pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
	pdf.set_font('Times-Roman')!
	page := pdf.append_page()
	page.add_barcode(.pdf_barcode_128a, 0, 0, 300, 10, 'Hello World', vpdfgen.pdf_white)!
	pdf.save('barcode.pdf')
	pdf.destroy()
}
