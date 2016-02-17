grantedData = read.csv("Text quality measures_Granted_ByClaims_Combined.csv", header=TRUE)
abandonedData$Percent_complex_words=0


for (i in 1:nrow(grantedData)) {
  
  if (nchar(as.character(toString(grantedData$Claim_text[i])), type="bytes") < 1) {
    next
  }
  
  grantedData$No_words[i]<- sapply(strsplit(toString(grantedData$Claim_text[i]), " "), length)
  grantedData$No_sentences[i]<- sapply(strsplit(toString(grantedData$Claim_text[i]), "\\."), length)
  
  grantedData$No_characters[i] <- nchar(as.character(toString(grantedData$Claim_text[i])), type="bytes")
  
  grantedData$Av_w_sentence[i]<-  grantedData$No_words[i]/grantedData$No_sentences[i]
  
  words_pre <- strsplit(toString(grantedData$Claim_text[i]), " ")
  words <- words_pre[[1]]
  
  words_syllables=0
  for (j in 1:length(words)){
    words_syllables[j] <-sapply(gregexpr("[aeiouy]+", words[j], ignore.case=TRUE), length)
  }
  
  grantedData$Av_syllable_w[i] <- sum(words_syllables)/grantedData$No_words
  
  grantedData$No_complex_words[i]= 0
  for(j in 1:length(words_syllables)) {
    if (words_syllables[j] >= 3) {
      grantedData$No_complex_words[i]=grantedData$No_complex_words[i]+1
    }
  }
  
  grantedData$Percent_complex_words[i] <- grantedData$No_complex_words[i]/grantedData$No_words[i]
  #print(grantedData$Percent_complex_words[i])
  
  
  grantedData$Flesch_Kincaid_Reading[i] = 206.835 - 1.015 * grantedData$Av_w_sentence[i] - 84.6 * grantedData$Av_syllable_w[i]
  grantedData$Flesch_Kincaid_Grade[i] = -15.59 + 0.39 * grantedData$Av_w_sentence[i] +11.8 * grantedData$Av_syllable_w[i]
  grantedData$Gunning_Fog[i] = 0.4 * ( grantedData$Av_w_sentence[i] + grantedData$Percent_complex_words[i] )
  grantedData$SMOG[i] = 1.0430* sqrt(30*grantedData$No_complex_words[i]/grantedData$No_sentences[i])+3.1291
  grantedData$Coleman_Liau[i] = 5.89*grantedData$No_characters[i]/grantedData$No_words[i]-0.3*grantedData$No_sentences[i]/grantedData$No_words[i]-15.8
  grantedData$ARI[i] = 4.71*grantedData$No_characters[i]/grantedData$No_words[i]+0.5*grantedData$Av_w_sentence[i]-21.43
}


write.csv(x=grantedData, file="granted_nov20_Harry.csv")
