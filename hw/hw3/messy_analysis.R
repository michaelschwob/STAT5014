d = read.csv("C:/Users/mschwob/Desktop/stat5014/extracted_records.csv")

f = function(x){
T = 0
for(i in 1:length(x)){
T = T + x[i]
}
m = T/length(x)
s = 0
for(i in 1:length(x)){
s = s + (x[i]-m)^2
}
return(c(m,sqrt(s/(length(x)-1))))
}

# pulse
res = c()
tmp = f(d$pulse)
res = c(res,tmp)
print(tmp)

# systolic
tmp2 = f(d$systolic)
res = c(res,tmp2)
print(tmp2)

# diastolic
tmp3 = f(d$diastolic)
res = c(res,tmp3)
print(tmp3)

a = d[d$site=="Clinic A",]
b = d[d$site=="Clinic B",]
cat("n in A",nrow(a),"n in B",nrow(b),"\n")
ma = f(a$pulse)[1]
mb = f(b$pulse)[1]
cat("difference in mean pulse",mb-ma,"\n")

# bootstrap the difference
B = 2000
dif = numeric(B)
for(i in 1:B){
sa = sample(a$pulse,nrow(a),replace=TRUE)
sb = sample(b$pulse,nrow(b),replace=TRUE)
dif[i] = mean(sb)-mean(sa)
}
ci = quantile(dif,c(0.025,0.975))
cat("95% CI",ci[1],ci[2],"\n")

# flag the fast ones
if(d$pulse > 100){
cat("tachycardic records found\n")
}

# check the high INR patients
hi = d[d$afib==1 & d$inr>4,]
for(i in 1:nrow(hi)){
cat("review record",hi$record_id[i],"inr",hi$inr[i],"\n")
}

png("figure1.png")
plot(d$age,d$pulse)
dev.off()

write.csv(res,"results.csv")
d$pulse[d$pulse==-99] = NA
write.csv(d,"extracted_records.csv",row.names=FALSE)
