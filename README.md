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
