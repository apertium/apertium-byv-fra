cat ~/apertium-byv-fra/corpora/byv.txt | sed "s/\([^ ]\)['’]\([^ ]\)/\1ʼ\2/g" | apertium-destxt | hfst-proc -w apertium-byv/byv.automorf.hfst | apertium-retxt | sed 's/\$\W*\^/$\n^/g' > /tmp/byv.wiki.cov

cat ~/apertium-byv-fra/corpora/byv.txt | sed "s/\([^ ]\)['’]\([^ ]\)/\1ʼ\2/g" | cut -f2 | sed 's/¶//g' | apertium -d apertium-byv-fra byv-fra-morph | sed 's/\$\W*\^/$\n^/g' > /tmp/byv-fra.wiki.cov

lex=`cat ~/apertium-byv/apertium-byv.byv.lexc | grep '^[^:]\+:[^ ]\+ *[A-Z]' | wc -l`
par=`cat ~/apertium-byv/apertium-byv.byv.lexc | grep -o 'LEXICON ' | wc -l`;
bidix=`cat ~/apertium-byv-fra/apertium-byv-fra.byv-fra.dix | grep '<l' | wc -l`;

bibtot=`cat /tmp/byv-fra.wiki.cov | wc -l`;
bibkno=`cat /tmp/byv-fra.wiki.cov | grep -v '\*' | wc -l`;
bibcov=`echo "($bibkno/$bibtot)*100" | bc -l | sed 's/^\./0./g'`;

wiktot=`cat /tmp/byv.wiki.cov | wc -l`;
wikkno=`cat /tmp/byv.wiki.cov | grep -v '\*' | wc -l`;
wikcov=`echo "($wikkno/$wiktot)*100" | bc -l | sed 's/^\./0./g'`;

d=`date`

echo -e "$d\tbyv-fra\t\t$bidix\t$bibkno/$bibtot\t$bibcov"
echo -e "$d\tbyv\t$par\t$lex\t$wikkno/$wiktot\t$wikcov"