# python3

# def auswertung_boroditsky():
# python3


import os
import xlrd
import numpy as np

genders_ger = ['m','f','f','f','m','f','m','m','f','m','m','f','f','m','f','m','m','m','m','m','f','m','f','m']

genders_por = ['f','m','m','m','f','m','f','f','m','f','f','m','m','f','m','f','f','f','f','f','m','f','m','f']

basedir = './raw'

files = [os.path.join(basedir, f) for f in os.listdir(basedir)]

port_ratings=[]
germ_ratings=[]


for file in files:
    if file.find('Rater') is not -1:
        if file.find('Portugiesisch') is not -1:
            port_ratings.append(file)
        if file.find('Deutsch') is not -1:
            germ_ratings.append(file)
    if file.find('Alle') is not -1:
        if file.find('Portugiesisch') is not -1:
            port_all = file
        if file.find('Deutsch') is not -1:
            germ_all = file    

# portugiesisch


raters = []


# get ratings per association
for file in port_ratings:
    book = xlrd.open_workbook(file)
    sheet = book.sheet_by_index(1)
    curr_rater={}
    for i in range(1,653):
        a = str(sheet.cell(i,1))[6:-1]
        b = int(str(sheet.cell(i,2))[7:-2])    
        curr_rater[a] = b
        #print(i)
        #print(file)
    raters.append(curr_rater)   # raters is a list of curr_raters
                                # curr_raters is a dict of 'word': 'rating'

filename = port_all
book = xlrd.open_workbook(filename)
sheet = book.sheet_by_index(0)

# get associations per association
associaters = []


for i in range(1,3600,72):
    words=[]
    for j in range(0,72,3):
        associations=[]
        associations.append(sheet.cell(i+j,1).value)
        associations.append(sheet.cell(i+j+1,1).value)
        associations.append(sheet.cell(i+j+2,1).value)
        words.append(associations)      # words is a collection of (#n items) associations
    associaters.append(words)           # associaters is a collection of associaters
                                        # each associater consists of his list of words,
                                        # each consisting of a list of 3 associations

                                        # associaters * words * associations

all_associations = []                   # one per word
missing = []


for associater in associaters:
    associater_results = []             # one per associater
    for words in associater:
        val = 0                         # becomes the sum of all ratings
        for word in words:              # of all associations for a word
            for curr_rater in raters:
                try:
                    val += curr_rater[word]
                except KeyError as e:
                    missing.append(str(e))
        associater_results.append(val)
    all_associations.append(associater_results)

out_all = ['subj,word,assoc_i,sex_port,sex_ger,sex,language,rating']

for subj_i, associater in enumerate(associaters):
    associater_results = []                               # one per associater
    for word_i, words in enumerate(associater):
        for assoc_i, word in enumerate(words):      # of all associations for a word
            val = 0                                       # becomes the sum of all ratings
            for curr_rater in raters:
                try:
                    val += curr_rater[word]
                except KeyError as e:
                    missing.append(str(e))
            line = ','.join((str(subj_i+1), str(word_i+1), str(assoc_i+1),
                                 genders_por[word_i], genders_ger[word_i],
                                 genders_por[word_i], 'por', str(val)))
            out_all.append(line)


por = all_associations                  # 50 associaters * 24 words * 1 rating sum each


# deutsch

raters = []


for file in germ_ratings:
    book = xlrd.open_workbook(file)
    sheet = book.sheet_by_index(1)
    curr_rater={}
    for i in range(1,653):
        a = str(sheet.cell(i,1))[6:-1]
        b = int(str(sheet.cell(i,2))[7:-2])    
        curr_rater[a] = b
        #print(i)
        #print(file)
    raters.append(curr_rater)


filename = germ_all

book = xlrd.open_workbook(filename)
sheet = book.sheet_by_index(0)


# get associations per association
associaters = []


for i in range(1,3600,72):
    words=[]
    for j in range(0,72,3):
        associations=[]
        associations.append(sheet.cell(i+j,1).value)
        associations.append(sheet.cell(i+j+1,1).value)
        associations.append(sheet.cell(i+j+2,1).value)
        words.append(associations)      # words is a collection of (#n items) associations
    associaters.append(words)           # associaters is a collection of associaters
                                        # each associater consists of his list of words,
                                        # each consisting of a list of 3 associations

                                        # associaters * words * associations

all_associations = []                   # one per word
missing = []


for associater in associaters:
    associater_results = []             # one per associater
    for words in associater:
        val = 0                         # becomes the sum of all ratings
        for word in words:              # of all associations for a word
            for curr_rater in raters:
                try:
                    val += curr_rater[word]
                except KeyError as e:
                    missing.append(str(e))
        associater_results.append(val)
    all_associations.append(associater_results)

# out_all = ['subj,word,assoc_i,sex_port,_sex_ger,sex,language,rating']

for subj_i, associater in enumerate(associaters):
    associater_results = []                               # one per associater
    for word_i, words in enumerate(associater):
        for assoc_i, word in enumerate(words):      # of all associations for a word
            val = 0                                       # becomes the sum of all ratings
            for curr_rater in raters:
                try:
                    val += curr_rater[word]
                except KeyError as e:
                    missing.append(str(e))
            line = ','.join((str(subj_i+51), str(word_i+1), str(assoc_i+1),
                                 genders_por[word_i], genders_ger[word_i],
                                 genders_ger[word_i], 'ger', str(val)))
            out_all.append(line)


ger = all_associations



out = ['subj,word,sex,language,rating']



for subject_i,words in enumerate(ger):
    for word_i,word in enumerate(words):
        line = (',').join([ str(subject_i+1), str(word_i+1), genders_ger[word_i], 'ger', str(word) ])
        out.append(line)



for subject_i,words in enumerate(por):
    for word_i,word in enumerate(words):
        line = (',').join([ str(subject_i+51), str(word_i+1), genders_ger[word_i], 'por', str(word) ])
        out.append(line)


outdir = './preproc'

outfile = outdir + '/boroditsky.csv'
with open(outfile, 'w', newline='') as fp:
    fp.write('\n'.join(str(line) for line in out))

outfile = outdir + '/boroditsky_all.csv'
with open(outfile, 'w', newline='') as fp:
    fp.write('\n'.join(str(line) for line in out_all))




outfile = outdir + '/por_out.csv'
with open(outfile, 'w', newline='') as fp:
    fp.write(','.join(str(n) for n in ((np.array(por)).mean(0) * [-1 if sex == 'm' else 1 for sex in genders_por])))

outfile = outdir + '/ger_out.csv'
with open(outfile, 'w', newline='') as fp:
    fp.write(','.join(str(n) for n in ((np.array(ger)).mean(0) * [-1 if sex == 'm' else 1 for sex in genders_ger])))


