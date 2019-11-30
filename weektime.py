#用来获取当前时间所在一周的结尾和开始
from datetime import datetime, timedelta,date    
date_str = '2019-11-1' 
date_obj = datetime.strptime(date_str, '%Y-%m-%d') 
date_obj  = date.today() 
#接下来的两部分是用来获取date类型的时间格式
start_of_week = date_obj - timedelta(days=date_obj.weekday())  # Monday 
end_of_week = start_of_week + timedelta(days=6)  # Sunday 
start_of_week =  date = datetime.strftime(start_of_week, '%y%m%d') 
end_of_week =  date = datetime.strftime(end_of_week , '%y%m%d') 
print(start_of_week) 
print(end_of_week)  





def gen_dates(b_date, days):
    day = timedelta(days=1)
    for i in range(days):
        yield b_date + day*i


def get_date_list(start=None, end=None):
    """
    这里传入时间都可以进行改写
    获取日期列表
    :param start: 开始日期
    :param end: 结束日期
    :return:
    """
    #这里写代码我自已进行解析时间
    '%y%m%d'
    start = datetime.strptime(start, '%y%m%d')
    end = datetime.strptime(end, '%y%m%d')
    
    # if start is None:
    #     start = datetime.strptime("2000-01-01", "%Y-%m-%d")
    # if end is None:
    #     end = datetime.now()
    data = []
    #这里传入的时间参数可以进行改变
    for d in gen_dates(start, (end+timedelta(days=1)-start).days):
        data.append(datetime.strftime(d,'%y%m%d'))
    return data

def  weektime_current():
    from datetime import date    
    # date_obj = datetime.strptime(date_str, '%Y-%m-%d') 
    date_obj  = date.today() 
    #接下来的两部分是用来获取date类型的时间格式
    start_of_week = date_obj - timedelta(days=date_obj.weekday())  # Monday 
    end_of_week = start_of_week + timedelta(days=6)  # Sunday 
    start_of_week =  date = datetime.strftime(start_of_week, '%y%m%d') 
    end_of_week =  date = datetime.strftime(end_of_week , '%y%m%d') 
    return get_date_list(start_of_week,end_of_week)