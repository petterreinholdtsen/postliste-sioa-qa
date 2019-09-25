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
	for y in 2018 ; do \
	  bin/tablecsv2db postjournal-sioa/$$y/*.csv > postjournal-sioa-$$y.tsv ; \
	done

npe-sioa.json:
	curl --silent 'https://norske-postlister.no/?query=%28document_from_org.orgnummer%3A948554062%29+OR+%28document_to_org.orgnummer%3A948554062%29&json' > $@.new && mv $@.new $@

compared-lists.txt: tsv npe-sioa.json
	bin/compare-sioa-norpostlister > $@.new && mv $@.new $@
