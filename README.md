# Multilingual Moral Political Dictionary (mMPD)

Kristina Bakkær Simonsen & Tobias Widmann 2023

Repo containing code and dictionary files for the multilingual moral
political dictionary measuring moral language in political text in 6
different languages. Details are described in the following article:

*Simonsen, K. B., & Widmann, T. (2023). When Do Political Parties
Moralize? A Cross-National Study of the Strategic Use of Moral Language
in Political Communication on Immigration. OSF Preprints.
<https://doi.org/10.31219/osf.io/hxd5a>*

Please start by reading this article which contains information about
the creation and performance of the dictionary. The dictionary files are
free to use for academic research. **In case you use one or multiple of
the dictionary files, please always cite the article above.**

Languages included in the mMPD are: **Danish, Dutch, English, German,
Spanish, and Swedish.**

In order to obtain all necessary files, start by downloading this repo.
The folder contains all dictionary files and a R-script to apply the
dictionary files. Code is shown below.

### Code to apply dictionary

The `mMPD` is provided in YAML format and can be applied via the
`quanteda` package.

    # Packages
    library(quanteda)
    library(tidyverse)

    # Set working directory to the downloaded folder called "mMPD-main"
    setwd("./mMPD-main")

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
