from gensim.models import Word2Vec as w2v
from gensim.models.phrases import Phrases, Phraser
import re
import spacy
import pandas as pd
import multiprocessing
import numpy as np
import math
from sklearn.linear_model import LogisticRegression
import _pickle as cPickle

def cleaning(doc):
    # Lemmatizes and removes stopwords
    # doc needs to be a spacy Doc object
    txt = [token.lemma_ for token in doc if not token.is_stop]
    # Word2Vec uses context words to learn the vector representation of a target word,
    # if a sentence is only one or two words long,
    # the benefit for the training is very small
    if len(txt) > 2:
        return ' '.join(txt)

def embed():
    data = pd.read_csv('embed.csv')

    text = data[' article']
    lines = pd.DataFrame({'article':[]})
    j = 0
    for a in text:
        line = []
        while True:
            try:
                idx = a.index('.')
                lines['article'][j] = a[0:idx]
                a = a[idx+1:]
                j+=1
            except:
                break
    nlp = spacy.load('en', disable=['ner', 'parser'])  
    brief_cleaning = (re.sub("[^A-Za-z']+", ' ', str(row)).lower() for row in lines['article'])

    txt = [cleaning(doc) for doc in nlp.pipe(brief_cleaning, batch_size=5000, n_threads=-1)]

    text = pd.DataFrame({'lines':txt}).dropna()
    sent = [row.split() for row in text['lines']]

    phrases = Phrases(sent, min_count=30, progress_per=10000)

    sentences = phrases[sent]

    cores = multiprocessing.cpu_count()

    w2v_model = w2v(min_count=20,
                         window=2,
                         size=300,
                         sample=6e-5, 
                         alpha=0.03, 
                         min_alpha=0.0007, 
                         negative=20,
                         workers=cores-1)
                         
    w2v_model.build_vocab(sentences, progress_per=10000)
    print("****embedding trained****")
    w2v_model.save('bruh.model')

def train_classifier():
    model = w2v.load("bruh.model")

    data = pd.read_csv('class.csv')

    text = data[' article']
    lines = []
    for a in text:
        if a==a:
            lines.append(a.split())

    articles = []
    for a in lines:
        doc = [word for word in a if word in model.wv.vocab]
        articles.append(np.mean([model.wv.__getitem__(w) for w in doc], axis=0).tolist())
       
    x = []
    y = []
    for i in range(len(articles)):
        if articles[i]==articles[i]:
            x.append(articles[i])
            y.append(data[' isrus '][i])
            
    X = np.array(x)
    Y = np.array(y)

    reg = LogisticRegression().fit(X, Y)

    # save the classifier
    with open('my_dumped_classifier.pkl', 'wb') as fid:
        cPickle.dump(reg, fid)  
    print('****classifier trained****')  
    
def test():
    data = pd.read_csv('test.csv')

    j = 0
    text = data[' article']
    lines = []
    rem = []
    for a in text:
        if a==a:
            lines.append(a.split())
        else:
            rem += [j]
        j +=1
    cleanData = data.drop(rem)

    model = w2v.load("bruh.model")
    articles = []
    for a in lines:
        doc = [word for word in a if word in model.wv.vocab]
        articles.append(np.mean([model.wv.__getitem__(w) for w in doc], axis=0).tolist())
       
    x = []
    for i in range(len(articles)):
        if articles[i]==articles[i]:
            x.append(articles[i])
    X = np.array(x)

    with open('my_dumped_classifier.pkl', 'rb') as fid:
        reg = cPickle.load(fid)
    Y = reg.predict_proba(X)
    Y = pd.DataFrame(Y)

    cleanData['rusrating'] = Y[1]
    cleanData.to_csv('results.csv', index = False)
    print('****testing complete****')
    return cleanData.values.tolist()
    
def run():
    embed()
    train_classifier()
    return test()
    
def main():
    run()

if __name__ == "__main__":
    main()

    