abandonedData = read.csv("Text quality measures_Abandoned_ByClaims_Combined.csv", header=TRUE)
abandonedData$Granted="0"
abandonedData$Percent_complex_words=0

for (i in 1:nrow(abandonedData)) {
  
  if (nchar(as.character(toString(abandonedData$Claim_text[i])), type="bytes") < 1) {
    next
  }
  
  abandonedData$No_words[i]<- sapply(strsplit(toString(abandonedData$Claim_text[i]), " "), length)
  abandonedData$No_sentences[i]<- sapply(strsplit(toString(abandonedData$Claim_text[i]), "\\."), length)
  
  abandonedData$No_characters[i] <- nchar(as.character(toString(abandonedData$Claim_text[i])), type="bytes")
  
  abandonedData$Av_w_sentence[i]<-  abandonedData$No_words[i]/abandonedData$No_sentences[i]
  
  words_pre <- strsplit(toString(abandonedData$Claim_text[i]), " ")
  words <- words_pre[[1]]
  
  words_syllables=0
  for (j in 1:length(words)){
    words_syllables[j] <-sapply(gregexpr("[aeiouy]+", words[j], ignore.case=TRUE), length)
  }
  
  abandonedData$Av_syllable_w[i] <- sum(words_syllables)/abandonedData$No_words
  
  abandonedData$No_complex_words[i]= 0
  for(j in 1:length(words_syllables)) {
    if (words_syllables[j] >= 3) {
      abandonedData$No_complex_words[i]=abandonedData$No_complex_words[i]+1
    }
  }
  
  abandonedData$Percent_complex_words[i] <- (abandonedData$No_complex_words[i])/ (abandonedData$No_words[i])
  #print(abandonedData$Percent_complex_words[i])
  
  
  abandonedData$Flesch_Kincaid_Reading[i] = 206.835 - 1.015 * abandonedData$Av_w_sentence[i] - 84.6 * abandonedData$Av_syllable_w[i]
  abandonedData$Flesch_Kincaid_Grade[i] = -15.59 + 0.39 * abandonedData$Av_w_sentence[i] +11.8 * abandonedData$Av_syllable_w[i]
  abandonedData$Gunning_Fog[i] = 0.4 * ( abandonedData$Av_w_sentence[i] + abandonedData$Percent_complex_words[i] )
  abandonedData$SMOG[i] = 1.0430* sqrt(30*abandonedData$No_complex_words[i]/abandonedData$No_sentences[i])+3.1291
  abandonedData$Coleman_Liau[i] = 5.89*abandonedData$No_characters[i]/abandonedData$No_words[i]-0.3*abandonedData$No_sentences[i]/abandonedData$No_words[i]-15.8
  abandonedData$ARI[i] = 4.71*abandonedData$No_characters[i]/abandonedData$No_words[i]+0.5*abandonedData$Av_w_sentence[i]-21.43
}


write.csv(x=abandonedData, file="abandoned_nov20_Harry.csv")
