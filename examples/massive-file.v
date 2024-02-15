module main

import vpdfgen

fn main() {
	info := &vpdfgen.PDF_Info{}
	pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
	pdf.set_font('Times-Roman')!
	for i in 0 .. 10 {
		page := pdf.append_page()
		page.add_text('page ${i}', 12, 50, 20, vpdfgen.pdf_black)!
		page.add_image_file(100, 500, 50, 150, './data/penguin.jpg')!
	}
	pdf.save('massive-file.pdf')
	pdf.destroy()
}
