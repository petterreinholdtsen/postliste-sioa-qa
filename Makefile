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
	for y in 2017 2018 2019 ; do \
	  bin/tablecsv2db postjournal-sioa/$$y/*.csv > postjournal-sioa-$$y.tsv ; \
	done

npe-sioa.json:
	curl --silent 'https://norske-postlister.no/?query=%28document_from_org.orgnummer%3A948554062%29+OR+%28document_to_org.orgnummer%3A948554062%29+OR+%28document_from_org.orgnummer%3A960658493%29+OR+%28document_to_org.orgnummer%3A960658493%29+OR+%28document_from_org.orgnummer%3A974104725%29++OR+%28document_to_org.orgnummer%3A974104725%29+OR+document_from_org.orgnavn%3A%22studentsamskipnaden+i+oslo%22+OR+document_to_org.orgnavn%3A%22studentsamskipnaden+i+oslo%22+OR+document_from_org.orgnavn%3A%22studentsamskipsn+i+oslo%22+OR+document_to_org.orgnavn%3A%22studentsamskipsn+i+oslo%22&json' > $@.new && mv $@.new $@

compared-lists: compared-lists-2019.txt compared-lists-2018.txt compared-lists-2017.txt

compared-lists-2019.txt: tsv npe-sioa.json
	bin/compare-sioa-norpostlister --year 2019 > $@.new && mv $@.new $@
compared-lists-2018.txt: tsv npe-sioa.json
	bin/compare-sioa-norpostlister --year 2018 > $@.new && mv $@.new $@
compared-lists-2017.txt: tsv npe-sioa.json
	bin/compare-sioa-norpostlister --year 2017 > $@.new && mv $@.new $@
