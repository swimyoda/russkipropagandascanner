for x in {1..57}; do
  curl -s https://en.news-front.info/post-sitemap$x.xml | xq | jq '.urlset.url[] | .loc' | cut -d "\"" -f 2 | while read p; do
    if [[ $p == "https://"* ]]; then
      curl -s $p | xmllint --html --xpath '//div[@class="article__content"]/p' - 2> /dev/null | sed  's/<[^>]*>//g' | tr '\n' ' ' | tr -d "," >> nf.txt
      echo -n ", " >> nf.txt
      echo -n $p >> nf.txt
      echo -n ", " >> nf.txt
      echo "" >> nf.txt
    else
      echo -n $p | tr -d "," >> nf.txt
      echo -n ", " >> nf.txt
    fi
  done
done
