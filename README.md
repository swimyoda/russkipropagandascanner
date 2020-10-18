# Russki Propaganda Scanner

This project is designed to detect linguistic patterns common to Russian propaganda from state-run media and find articles from non-Russian sources which share these patterns.

We collected a large number of articles from RT.com, News Front (both Russian state-run media sites), Reuters (presumably objective media), and Fox News (potentially linguistically similar to Russian propaganda). We then trained a word2vec embedding with the RT articles with which we featurized the News Front and Reuters articles. We then trained a logistic regression classifier to predict whether the article was Russian or nuetral. We then applied this model to some of the RT articles and the Fox News articles to generate the probability of the article being Russian - our "Russki Index". We found that many Fox News articles had a notably high Russki Index - just as high or higher than many RT articles. 

Our goal is to create a website where people can see article text and Russki Index of these articles to become more aware of how Russian propaganda narratives spread to more legitimate news agencies. In the future, we hope to enable people to look up particular keywords and see articles from various sources which have a high Russki Index to be able to track these narratives in real time.

Our website will be hosted at [russkipropagandascanner.tech](russkipropagandascanner.tech)

Спасибо за интерес к нашему проекту!

# Overview of Repo

- doitall.py: Does all the preprocessing, embedding, training, and testing
- embed.csv:  File with the data to train the embeding
- class.csv:  File with the data to train the classifer
- test.csv:   File with data to test out our classifier
