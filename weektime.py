In [4]: from datetime import datetime, timedelta,date 
   ...:   
   ...: date_str = '2019-11-1' 
   ...: date_obj = datetime.strptime(date_str, '%Y-%m-%d') 
   ...: date_obj  = date.today() 
   ...: start_of_week = date_obj - timedelta(days=date_obj.weekday())  # Monday 
   ...: end_of_week = start_of_week + timedelta(days=6)  # Sunday 
   ...: print(start_of_week) 
   ...: print(end_of_week)  
