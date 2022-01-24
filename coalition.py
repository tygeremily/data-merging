#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 13 10:45:48 2020

@author: emilytyger
"""
import requests 
from bs4 import BeautifulSoup
import pandas as pd

# years 1995-2020
urla = 'https://en.wikipedia.org/wiki/'

coalitiondf = pd.DataFrame(columns=['country', 'year', 'coalition'])

#%% Peru 
peru_url = '_Peruvian_general_election'
years = ['1995', '2000', '2001', '2006', '2011', '2016', '2020']

urls = pd.DataFrame({'country': 'Peru',
                     'year': [year for year in years],
                     'url': [urla + year + peru_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception


#%% mozambique
moz_url = '_Mozanbican_general_election'
years = ['1999', '2004', '2009', '2014', '2019']

urls = pd.DataFrame({'country': 'Mozanbique',
                     'year': [year for year in years],
                     'url': [urla + year + moz_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception

#%% albania
alb_url = '_Albanian_parliamentary_election'
years = ['1996', '1997', '2001', '2005', '2009', '2013', '2017']

urls = pd.DataFrame({'country': 'Albania',
                     'year': [year for year in years],
                     'url': [urla + year + alb_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception

#%% nigeria
n_url = '_Nigerian_general_election'
years = ['1998', '1999', '2003', '2007', '2011', '2015', '2019']

urls = pd.DataFrame({'country': 'Nigeria',
                     'year': [year for year in years],
                     'url': [urla + year + n_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception      
   
#%% gabon
gab_url = '_Gabonese_legislative_election'
years = ['1996', '2001', '2006', '2011', '2018']

urls = pd.DataFrame({'country': 'Gabon',
                     'year': [year for year in years],
                     'url': [urla + year + gab_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception
  
#%% mauritania
maur_url = '_Mauritian_general_election'
years = ['1995', '2000', '2005', '2010', '2014', '2019']

urls = pd.DataFrame({'country': 'Mauritania',
                     'year': [year for year in years],
                     'url': [urla + year + peru_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception    
      
#%% sri lanka
# The 2020 election has been postponed due to COVID-19 but the page still 
# exists so I am including it
sri_url = '_Sri_Lankan_parliamentary_election'
years = ['2000', '2001', '2004', '2010', '2015', '2020']

urls = pd.DataFrame({'country': 'Sri Lanka',
                     'year': [year for year in years],
                     'url': [urla + year + sri_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception        
       
#%% afghanistan
af_url = '_Afghan_parliamentary_election'
years = ['2005', '2010', '2018']

urls = pd.DataFrame({'country': 'Afghanistan',
                     'year': [year for year in years],
                     'url': [urla + year + af_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception       
        
#%% zambia
zam_url = '_Zambian_general_election'
years = ['1996', '2001', '2006', '2011', '2016']

urls = pd.DataFrame({'country': 'Zambia',
                     'year': [year for year in years],
                     'url': [urla + year + zam_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception      
        
#%% turkey
t_url = '_Turkish_general_election'
years = ['1995', '1999', '2002', '2007', '2011', 'June_2015', 'November_2015',
         '2018']

urls = pd.DataFrame({'country': 'Turkey',
                     'year': [year for year in years],
                     'url': [urla + year + t_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception       
        
#%% montenegro
mon_url = '_Montenegrin_parliamentary_election'
years = ['1996', '1998', '2001', '2002', '2006', '2009', '2012', '2016', 
         '2020']

urls = pd.DataFrame({'country': 'Montenegro',
                     'year': [year for year in years],
                     'url': [urla + year + mon_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception       
        
#%% nicaragua
nic_url = '_Nicaraguan_general_election'
years = ['1996', '2001', '2006', '2011', '2016']

urls = pd.DataFrame({'country': 'Nicaragua',
                     'year': [year for year in years],
                     'url': [urla + year + nic_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception       
        
#%% republic of the congo 
rc_url = '_Democratic_Republic_of_the_Congo_general_election'
years = ['2006', '2011', '2018']

urls = pd.DataFrame({'country': 'Republic of Congo',
                     'year': [year for year in years],
                     'url': [urla + year + rc_url for year in years]})



for u in range(len(urls)):
    try: 
        c = requests.get(urls.loc[u, 'url'])
        cs = BeautifulSoup(c.text, 'html.parser')
        tf = bool(cs.findAll(text = 'coalition'))
        tf_df = pd.DataFrame({'country': [urls.loc[u, 'country']],
                              'year': [urls.loc[u, 'year']],
                              'coalition': 1 if tf == True else 0})
        coalitiondf = coalitiondf.append(tf_df)
        
    except:
        Exception       

#%% 
coalitiondf.to_csv("coalition.csv")
        