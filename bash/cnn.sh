curl -s https://www.cnn.com/sitemaps/cnn/index.xml  | xq | jq '.sitemapindex.sitemap[] | select(.loc | contains("/article-")) | .loc' | cut -d "\"" -f 2 | while read h; do echo $h; done | while read p; do
  if [[ $p == "https://"* ]]; then
    curl --limit-rate 20k -A "spotnik" -s $p | xmllint --html --xpath '//div[@class="article-body"]/p' - 2> /dev/null | sed  's/<[^>]*>//g' | tr '\n' ' ' | tr -d "," >> cnn.txt
    echo -n ", " >> cnn.txt
    echo -n $p >> cnn.txt
    echo -n ", " >> cnn.txt
    echo "" >> cnn.txt
  else
    echo -n $p | tr -d "," >> cnn.txt
    echo -n ", " >> cnn.txt
  fi
done
