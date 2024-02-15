module main

import vpdfgen

fn main() {
	info := &vpdfgen.PDF_Info{}
	pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
	pdf.set_font('Times-Roman')!
	page := pdf.append_page()
	page.add_image_file(100, 500, 50, 150, './data/coal.png')!
	pdf.save('image-file.pdf')
	pdf.destroy()
}
