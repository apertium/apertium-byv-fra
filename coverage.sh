cat /home/anakuz/apertium-languages/apertium-byv-fra/corpora/byv.txt| sed "s/\([^ ]\)['’]\([^ ]\)/\1ʼ\2/g" | apertium-destxt | hfst-proc -w /home/anakuz/apertium-languages/apertium-byv/byv.automorf.hfst | apertium-retxt | sed 's/\$\W*\^/$\n^/g' > tmp/byv.cov


cat /home/anakuz/apertium-languages/apertium-byv-fra/corpora/byv.txt | sed "s/\([^ ]\)['’]\([^ ]\)/\1ʼ\2/g" | cut -f2 | sed 's/¶//g' | apertium -d /home/anakuz/apertium-languages/apertium-byv-fra byv-fra-morph | sed 's/\$\W*\^/$\n^/g' > tmp/byv-fra.cov

lex=`cat /home/anakuz/apertium-languages/apertium-byv/apertium-byv.byv.lexc | grep '^[^:]\+:[^ ]\+ *[A-Z]' | wc -l`
par=`cat /home/anakuz/apertium-languages/apertium-byv/apertium-byv.byv.lexc | grep -o 'LEXICON ' | wc -l`;
bidix=`cat /home/anakuz/apertium-languages/apertium-byv-fra/apertium-byv-fra.byv-fra.dix | grep '<l' | wc -l`;

bibtot=`cat tmp/byv-fra.cov | wc -l`;
bibkno=`cat tmp/byv-fra.cov | grep -v '\*' | wc -l`;
bibcov=`echo "($bibkno/$bibtot)*100" | bc -l | sed 's/^\./0./g'`;
wiktot=`cat tmp/byv.cov | wc -l`;
wikkno=`cat tmp/byv.cov | grep -v '\*' | wc -l`;
wikcov=`echo "($wikkno/$wiktot)*100" | bc -l | sed 's/^\./0./g'`;

d=`date`

echo -e "$d\tbyv-fra\t\t$bidix\t$bibkno/$bibtot\t$bibcov"
echo -e "$d\tbyv\t$par\t$lex\t$wikkno/$wiktot\t$wikcov"