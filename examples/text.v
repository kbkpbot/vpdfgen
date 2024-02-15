module main

import vpdfgen

const text = 'Simple C PDF Creation/Generation library. All contained a single C-file with header and no external library dependencies. Useful for embedding into other programs that require rudimentary PDF output. Supports the following PDF features'

fn main() {
	info := &vpdfgen.PDF_Info{}
	pdf := vpdfgen.new_pdf(vpdfgen.pdf_a4_width, vpdfgen.pdf_a4_height, info)!
	pdf.set_font('Times-Roman')!
	page := pdf.append_page()
	page.add_text(text, 10, 100, 100, vpdfgen.pdf_green)!
	_ := page.add_text_wrap(text, 10, 100, 300, 0, vpdfgen.pdf_blue, 200, .pdf_align_left)!
	pdf.save('text.pdf')
	pdf.destroy()
}
