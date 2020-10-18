# Russki Propaganda Scanner

Our website will be running at [russkipropagandascanner.tech](russkipropagandascanner.tech)

## Goals
Our goal is to create a website where people can see article text and Russki Index of these articles to become more aware of how Russian propaganda narratives spread to more legitimate news agencies. Because foreign disinformation is such an insidious issue, we hope that this project can help to shed some light on the issue and give people a resource to improve their understanding of (and resiliency to) this dangerious phenomenon.

## Process
This project is designed to detect linguistic patterns common to Russian propaganda from state-run media and find articles from non-Russian sources which share these patterns.

We collected a large number of articles from RT.com, News Front (both Russian state-run media sites), Reuters (presumably objective media), and Fox News (potentially linguistically similar to Russian propaganda). We then trained a word2vec embedding with the RT articles with which we featurized the News Front and Reuters articles. We then trained a logistic regression classifier to predict whether the article was Russian or nuetral. We then applied this model to some of the RT articles and the Fox News articles to generate the probability of the article being Russian - our "Russki Index". We found that many Fox News articles had a notably high Russki Index - just as high or higher than many RT articles. 

## Future Updates
In the future, we hope to enable people to look up particular keywords and see articles from various sources which have a high Russki Index to be able to track these narratives in real time. Additionally, we would like to go back to work on making the model more explainable. We could ideally highlight certain aspects of of the article which point to it being highly propagandistic. We also would like to make the site mobile responsive:)

## Challanges
While Tom and Hunter each had some experience with machine learning and data science in general, the NLP techniques such as word2vec encoding were completely new. Learning them was challenging, but extemely rewarding. Matthew had no experience with machine learning at all, but came away with a working understanding of the subject, specifically using sci-kit learn for logistic or linear regression. 

Спасибо за интерес к нашему проекту!

## Overview of Repo

- doitall.py: Does all the preprocessing, embedding, training, and testing
- data: Directory with the training and testing data
  - embed.csv:  File with the data to train the embeding
  - class.csv:  File with the data to train the classifer
  - test.csv:   File with data to test out our classifier
  - results.csv: The text, title, url and Russki Index for the text data as calculated by the classifier
- web: directory with website source
- harvesting: directory with webscraping scripts used to collect data
