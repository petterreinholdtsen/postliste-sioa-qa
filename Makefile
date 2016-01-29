all: pdftable-code

pdftable-code:
	svn checkout svn://svn.code.sf.net/p/pdftable/code/ pdftable-code

pdfs:
	mkdir -p postjournal-sioa
	cd postjournal-sioa; ../bin/fetch-postliste-sioa-pdfs

csv: pdftable-code pdfs
	for f in postjournal-sioa/*/*.pdf ; do \
	  pdftohtml -xml -stdout "$$f" | \
	    python pdftable-code/pdftable.py > "$$f".csv ; \
	done

tsv:
	for y in 2016 ; do \
	  bin/tablecsv2db postjournal-sioa/$$y/*.csv > postjournal-sioa-$$y.tsv ; \
	done
