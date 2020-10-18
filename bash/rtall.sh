curl -s https://www.rt.com/sitemap_2020.xml | xq | jq '.urlset.url[] | select((.loc | contains("/news/")) or (.loc | contains("/uk/")) or (.loc | contains("/usa/"))) | .loc' | cut -d "\"" -f 2 | while read p; do
  if [[ $p == "https://"* ]]; then
    curl --limit-rate 20k -A "sputnik" -s $p | xmllint --html --xpath '//div[@class="article__text text "]/p' - 2> errors | sed  's/<[^>]*>//g' | tr '\n' ' ' | tr -d "," >> rtall.txt
    if [[ $? -eq 1 ]]; then
      echo $p
    fi
    echo -n ", " >> rtall.txt
    echo -n $p >> rtall.txt
    echo -n ", " >> rtall.txt
    echo "" >> rtall.txt
  else
    echo -n $p | tr -d "," >> rtall.txt
    echo -n ", " >> rtall.txt
  fi
done
