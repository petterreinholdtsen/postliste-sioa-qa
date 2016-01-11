Kvalitetssjekk av postjournalen til Studentsamskipnaden i Oslo og Akershus
==========================================================================

I følge Studentsamskipnaden i Oslo og Akershus (SiOA) sin egen policy
for åpenhet og tilgjengelighet([1]) skal postlistene "inneholde
korrespondanse SIO har med samarbeidspartnere, privatpersoner,
medlemsinstitusjoner, myndigheter og andre".  Postlistene skal
publiseres ukentlig og inneholde "all inn- og utgående post som er
journalført uken før".  Men blir det gjort?

Litt historikk rundt åpenhetspolicyen til SiOA finnes fra en
evaluering gjort av velferdstinget([2]).

 [1]: http://webhttp.sio.no/files/info/files/postlister/Apenhetspolicy_SiO_web.pdf "Policy for åpenhet og tilgjengelighet"
 [2]: http://www.studentvelferd.no/dokumenter/2012/04/Vedlegg-til-evaluering-av-SiOs-%25C3%25A5penthetspolicy.pdf "Vedlegg til Evaluering av SiOs åpenhetspolicy"

Det hadde vært interessant å kvalitetssikre postjournalene, og se om
SiOA lykkes med å registrere det de sier skal registreres i
postjournalene.

Metoden er å sammenligne offentlige postjournaler som Offentlig
Elektronisk Postjournal (oep.no), og se om det som er sendt og mottatt
hos offentlige kontorer til/fra SiOA er journalført hos SiOA.

Aktuelle postjournaler fra OEP er hentet ut med

  $ sqlite3 data/postliste-oep.sqlite  "select agency,caseyear,caseseqnr,casedocseq,docdate,sender,recipient,docdesc from swdata where sender like 'Studentsamskipnaden i Oslo%' or recipient like 'Studentsamskipnaden i Oslo%' order by docdate";

Postjournalen tilgjenglig fra SiOA([3]) må konverteres fra PDF til
databaseformat for enkel sammenligning.  Det gjøres antagelig greiest
med [pdftable](http://sourceforge.net/projects/pdftable).

 [3]: https://www.sio.no/snarveier/om-sio/rapporter-og-referater "Rapporter og referater"
