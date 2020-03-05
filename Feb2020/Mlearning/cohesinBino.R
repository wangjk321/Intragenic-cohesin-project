args=commandArgs(T)
coh <- args[1]
tf <- args[2]

cat("cohesin bed =", coh, "\n")
cat("transcription factor interbed =", tf, "\n")
id <-  strsplit(get("tf"),"[.]")[[1]][1]

cohesin <- read.table(coh, header=F)
tfinter <- read.table(tf,header=F)

cohPos <- paste(as.character(cohesin[,1]),as.character(cohesin[,2]),as.character(cohesin[,3]),sep="-")
tfPos <- paste(as.character(tfinter[,1]),as.character(tfinter[,2]),as.character(tfinter[,3]),sep="-")

x <- match(cohPos,tfPos)
x[!is.na(x)] <- 1
x[is.na(x)] <- 0
xx <- as.matrix(x)
colnames(xx) <- id

###add cohesin sites to 1st coloum
position <- as.matrix(cohPos)
colnames(position) <- c("cohesinPos")
mt <- cbind(position,xx)
###

filename <- paste("binotxt/",id,".txt", sep="")
write.table(mt,filename,sep="\t",row.names = F,col.names = T,quote = F)

