curl -s 'https://www.foxnews.com/sitemap.xml?type=articles&from=1416248216000'  | xq | jq '.urlset.url[] | .loc' | cut -d "\"" -f 2 | while read p; do
  if [[ $p == "https://"* ]]; then
    curl --limit-rate 20k -A "sputnik" -s $p | xmllint --html --xpath '//div[@class="article-body"]/p' - 2> /dev/null | sed  's/<[^>]*>//g' | tr '\n' ' ' | tr -d "," >> foxall.txt
    echo -n ", " >> foxall.txt
    echo -n $p >> foxall.txt
    echo -n ", " >> foxall.txt
    echo "" >> foxall.txt
  else
    echo -n $p | tr -d "," >> foxall.txt
    echo -n ", " >> foxall.txt
  fi
done
