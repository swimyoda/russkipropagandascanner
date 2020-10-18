curl -s https://www.reuters.com/sitemap_news_index1.xml  | xq | jq '.urlset.url[] | .loc, ."news:news"."news:title"' | cut -d "\"" -f 2 | while read p; do
  if [[ $p == "https://"* ]]; then
    curl -s $p | xmllint --html --xpath '//div[@class="ArticleBodyWrapper"]/p' - 2> /dev/null | sed  's/<[^>]*>//g' | tr '\n' ' ' | tr -d "," >> reuters.txt
    echo -n ", " >> reuters.txt
    echo -n $p >> reuters.txt
    echo -n ", " >> reuters.txt
    echo "" >> reuters.txt
  else
    echo -n $p | tr -d "," >> reuters.txt
    echo -n ", " >> reuters.txt
  fi
done
