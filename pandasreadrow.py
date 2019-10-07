


# https://www.shanelynn.ie/select-pandas-dataframe-rows-and-columns-using-iloc-loc-and-ix/#iloc-selection
dfs = pd.read_excel('./10Y国债.xlsx') 

for k in range(1912): 
     ...:     alldata.append([dfs.iloc[k]["日期"],dfs.iloc[k]["开盘"],dfs.iloc[k]["最高"],dfs.iloc[k]["最低"],dfs.iloc[k]["收盘"],dfs.iloc[k]["成交笔数"
     ...: ],"gz"]) 