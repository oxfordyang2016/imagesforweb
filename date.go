 func getmonthday(datestring string) []string {	
    layout1 := "2006-01-02"
    //str := "2019-03-19"
    t1, err := time.Parse(layout1, "2019-04-06")
  
    if err != nil {
        fmt.Println(err)
    }
    fmt.Println(t1)
  
  
  
          fmt.Println("Hello, playground")
     //layout := "2010-04-06"
    //str := "2019-03-19"
  //layout := "2006-01-02"
    t, err := time.Parse(layout1,"2019-04-06")
    fmt.Println(t)
    if err != nil {
        fmt.Println(err)
    }
  
      currentYear, currentMonth, _ := t.Date()
      //currentLocation := t.Location()
      loc, _ := time.LoadLocation("Asia/Shanghai")
      firstOfMonth := time.Date(currentYear, currentMonth, 1, 0, 0, 0, 0, loc)
      lastOfMonth := firstOfMonth.AddDate(0, 1, -1)
  
      var daterange []string
      daterange = append(daterange,firstOfMonth.Format("2006-01-02"))
       day := firstOfMonth
          for day !=lastOfMonth {
                 day =  day.AddDate(0, 0, 1)
                   daterange = append(daterange,day.Format("2006-01-02"))
          }
  
  
  
      fmt.Println(firstOfMonth)
      fmt.Println(lastOfMonth)
  fmt.Println(daterange)
  return daterange
    }