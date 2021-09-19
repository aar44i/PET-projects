library(kernlab)
library(dplyr)
library(zoo)

data=read.csv2('data.csv', header = T, stringsAsFactors = F)
data$REPORTDATE = as.Date(data$REPORTDATE,format = '%d.%m.%Y')

#Логарифмируем объемы

data$VALUE = log(data$VALUE)

#Функция расчета стабильной части на дату

stableOnDate = function(report_date, data){
  
  
  h  = 366
  t = report_date + -h:365
  
  
  
  df = filter(data, REPORTDATE > report_date - h, REPORTDATE <= report_date)
  
  #масштабируем данные
  y  = df$VALUE; my = mean(y) ; sdy = sd(y);   y = (y - my)/sdy
  
  
  x_and_xpredict = 1:(h+365) 
  
  
  L = length(x_and_xpredict)
  
  
  
  
  
  
  
  trend    = function(x,y)   1/(x+365) * 1/(y+365)
  seasonRBF = function(len,period) function(x,y) exp(- (1/(len)^2)* 2*(sin(pi*abs(x-y)/period))^2  )
  
  #Применить функцию к попарным значениям
  makeMat   = function(x,fun) outer(x,x,fun)
  
  #Масштабируем матрицу тренда
  Ktrend   = makeMat(x_and_xpredict,trend) ; Ktrend = (Ktrend - mean(Ktrend)); Ktrend = (Ktrend)/max(Ktrend)
  Season  = function(x,f)   makeMat(x_and_xpredict,seasonRBF(1,x) )
  
  
  
  
  
  
  M  = 1:h
  M2 = 1:L ; M2 = M2[!M2 %in% M]
  
  
  
  makeFitandPredict = function(K,y,q){
    
    K_train = K[M,M] ; class(K_train) <- "kernelMatrix"
    K_pred  = K[M2,M] ; class(K_pred) <- "kernelMatrix"
    model   = kqr(K_train,y,tau=q)
    fit     = predict(model,K_train)
    pred    = predict(model,K_pred) 
    list(fit = fit,pred = pred)
  }
  
  
  K    =  1e2*Ktrend   + diag(0.1,L,L)
  res  =  makeFitandPredict(K,y,0.01)
  
  
  pred = res$pred 
  fit  = res$fit
  
  residuals = y - fit
  
  
  K    =    1e2*Season(365) + diag(0.1,L,L) 
  res2 =    makeFitandPredict(K,residuals,0.01)
  
  
  pred = res2$pred + pred 
  fit  = res2$fit + fit
  
  
  
  #Обратное масштабирование
  pred = pred*sdy  + my
  fit  = fit*sdy   + my
  
  
  #Бакеты
  ts      = seq(365/12,365,365/12)
  
  #Посчитаем для каждого бакета стабильную часть
  stable_levels = lapply(ts,function(t) c(last(df$VALUE),head(pred,t))%>% min)
  stable_levels = as.numeric(stable_levels)
  names = c('1m','2m','3m','4m','5m','6m','7m','8m','9m','10m','11m','12m')
  
  
  
  res   = data.frame(report_date = report_date,
                     bucket = names,
                     stable = stable_levels
  )
  
  
}








#Факт стабильной части на дату на горизонте h, на дату report_date
stablesFact = function(h,report_date,data=data){
  df = filter(data,REPORTDATE <= report_date+h, REPORTDATE >= report_date)
  min(df$VALUE)
}
  


#Cравниваем

t = as.Date('2018-08-23')
model = stableOnDate(t,data)

stab31 = stablesFact(31,t,data) %>% exp

model31 = filter(model, bucket == '1m')$stable %>% exp



  
