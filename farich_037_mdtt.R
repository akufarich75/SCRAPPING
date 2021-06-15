library("NLP")#import package yang dibutuhkan untuk NLP
library("openNLP")
library("openNLPdata")

#simpan kalimat yang ingin di post tagging didalam vaiarble kalimat
kalimat = "Data science is my main skill because my educational background is statistics. I have participated in several events with the theme of data science on campus and community. Lead the team that passed the top 7 by participating in the DFTU Competition, Datavidia Competition and Satria Data by passing the top 10 with the case NLP : fake news classification and sentiment analysis. I have already lead the Rakamin Academy project team with vehicle price predictions. Currently, I am leading the project team to build a health dashboard for the Sampang city government"
kalimat <- as.String(kalimat)
kalimat

#beri keterangan pada kalimat menggunakan fungsi`Maxent_Sent_Token_ Annotator ()`
sentAnnotator <- Maxent_Sent_Token_Annotator(language = "en", probs =TRUE, model =NULL)
sentAnnotator

#Menampilkan tabel informasi kalimat yang terdeteksi
annotated_sentence <- annotate(kalimat,sentAnnotator)
annotated_sentence

actualSentence <- kalimat#menunjukkan pembagian kalimat
actualSentence [annotated_sentence]

# Memberikan anotasi pada setiap kata
wordAnnotator <- Maxent_Word_Token_Annotator(language = "en", probs =TRUE, model =NULL)
annotated_word<- annotate(kalimat,wordAnnotator,annotated_sentence)
head(annotated_word)

#Setiap kata sudah dianotasi beserta peluang terdeteksinya
#Sekarang, melakukan POS Tagging pada kalimat dimana annotator kata&kalimat diterapkan
install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at/", type = "source")
library("openNLPmodels.en")

#Load model POS dari disk ke memori
pos_token_annotator_model <- Maxent_POS_Tag_Annotator(language = "en",probs = TRUE, model = system.file("models", "en-pos-perceptron.bin",
package = "openNLPmodels.en"))

pos_tag_annotator <- Maxent_POS_Tag_Annotator(language = "en", probs =TRUE, model =NULL)
pos_tag_annotator

#penanda POS sekarang siap untuk menandai data. Ia mengharapkan kalimat tokenized sebagai input, yang direpresentasikan sebagai array string; setiap objek string dalam array adalah satu token:
posTaggedSentence <- annotate(kalimat, pos_tag_annotator, annotated_word)
posTaggedSentence#kita dapat melihat bahwa setiap kata berisi satu bagian tag ucapan, indeks awal dan akhir kata, dan level kepercayaan setiap tag:

#Membuat distribusi POS tagging untuk token kata
posTaggedWords <- subset(posTaggedSentence, type == "word")
posTaggedWords

#Mengambil hanya kolom features
tags <- sapply(posTaggedWords$features, `[[`, "POS")
tags

table(tags)#Menghitung jumlah setiap tag yang ada di semua kalimat
sprintf("%s -- %s", kalimat[posTaggedWords], tags)# Menampilkan setiap kata beserta tag nya

