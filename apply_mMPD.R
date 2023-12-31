
# Packages
library(quanteda)
library(tidyverse)

# Set working directory to the downloaded folder called "mMPD"
setwd("./mMPD")

# Load Dictionary Files

#danish
mMPD_da <- dictionary(file = "./dictionary_files/mMPD_da.yml",
                      format = "YAML")
#german
mMPD_de <- dictionary(file = "./dictionary_files/mMPD_de.yml",
                  format = "YAML")
#english
mMPD_en <- dictionary(file = "./dictionary_files/mMPD_en.yml",
                      format = "YAML")
#spanish
mMPD_es <- dictionary(file = "./dictionary_files/mMPD_es.yml",
                      format = "YAML")
#dutch
mMPD_nl <- dictionary(file = "./dictionary_files/mMPD_nl.yml",
                      format = "YAML")
#swedish
mMPD_sv <- dictionary(file = "./dictionary_files/mMPD_sv.yml",
                     format = "YAML")


#  Choose language file
dic <- dictionary(mMPD_en) #run this line for English dictionary
dic <- dictionary(mMPD_de) #run this line for German dictionary
dic <- dictionary(mMPD_da) #run this line for Danish dictionary
dic <- dictionary(mMPD_sv) #run this line for Swedish dictionary
dic <- dictionary(mMPD_nl) #run this line for Dutch dictionary
dic <- dictionary(mMPD_es) #run this line for Spanish dictionary


# Create application function
apply_dic <- function(data){
  #Create a corpus from your data frame
  corp <- corpus(data)
  
  #Tokenize corpus and pre-process (remove punctuations, numbers, and urls)
  toks <- tokens(corp, remove_punct = TRUE, remove_numbers = TRUE, remove_url = TRUE)
  
  #Create DFM 
  terms_dfm <- dfm(toks)
  
  #Apply dictionary
  dict_dfm_results <- dfm_lookup(terms_dfm, dic)
  
  #Convert results back to data frame
  results_df <- cbind(data, convert(dict_dfm_results, to = 'data.frame'))
  
  #Assign length to each documents
  results_df$terms <- ntoken(terms_dfm)

  return(results_df)
}

#Now you can use the function on your data; simply enter a data frame with a column called "text" including the text data
results <- apply_dic(cc_english_prepared)

#Take a look at the resulting dataframe
glimpse(results)




