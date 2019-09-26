package models
import(
  "fmt"
  //"os/exec"
  //"os"
  "time"
  "net/http"
  "github.com/jinzhu/gorm"
	"strconv"
//"github.com/jinzhu/gorm"
//"github.com/gin-contrib/sessions"
"github.com/gin-gonic/gin"
)






type Goods struct {
  gorm.Model
   Email    string   `json:"email"`     
   //Details string `json:"details" sql:"type:text;"`
   Goodsname  string   `json:"goodsname"`  
   Note  string   `json:"note"` 
   Date string   `json:"date"`
   Highest float64   `json:"highest"`
   Lowest float64  `json:"lowest"`
   Open float64   `json:"open"`
   Close float64   `json:"close"`
   Volume float64   `json:"volume"`
  }



  type Goodsofweek struct {
    gorm.Model
     Email    string   `json:"email"`     
     //Details string `json:"details" sql:"type:text;"`
     Goodsname  string   `json:"goodsname"`  
     Note  string   `json:"note"` 
     Date string   `json:"date"`
     Highest float64   `json:"highest"`
     Lowest float64  `json:"lowest"`
     Open float64   `json:"open"`
     Close float64   `json:"close"`
     Volume float64   `json:"volume"`
    }



    type Goodsofmonth struct {
      gorm.Model
       Email    string   `json:"email"`     
       //Details string `json:"details" sql:"type:text;"`
       Goodsname  string   `json:"goodsname"`  
       Note  string   `json:"note"` 
       Date string   `json:"date"`
       Highest float64   `json:"highest"`
       Lowest float64  `json:"lowest"`
       Open float64   `json:"open"`
       Close float64   `json:"close"`
       Volume float64   `json:"volume"`
      }








func Getmywealth (c *gin.Context){

  var balance = 1520

  c.JSON(200, gin.H{
						"status": "blog had updated",
						"blance":balance,
                })
}


func Graphforinvest(c *gin.Context){

  c.HTML(http.StatusOK, "invest.html",nil)
 
}


func Recordwebpage(c *gin.Context){

  c.HTML(http.StatusOK, "data.html",nil)
 
}




func Getdatafromserver(c *gin.Context){
  var goodsdata []Goods
  var goodsdataofweek []Goodsofweek
  var goodsdataofmonth []Goodsofmonth
  var timelap = c.Query("timelap")
  var goodsname = c.Query("goodsname")
  if timelap == "week" {
    db.Order("date").Where("goodsname=?",goodsname).Find(&goodsdataofweek)
    c.JSON(200, gin.H{
      "goodsdata": goodsdataofweek,
      "message": "u have uploaded info,please come on!",
    })
  }
  if timelap == "day"{
    db.Order("date").Where("goodsname=?",goodsname).Find(&goodsdata)
    fmt.Println(goodsdata)
    c.JSON(200, gin.H{
      "goodsdata": goodsdata,
      "message": "u have uploaded info,please come on!",
    })
    
   }//db.Find(&goodsdata)

   if timelap == "month"{
    db.Order("date").Where("goodsname=?",goodsname).Find(&goodsdataofmonth)
    c.JSON(200, gin.H{
      "goodsdata": goodsdataofmonth,
      "message": "u have uploaded info,please come on!",
    })
    
   }//db.Find(&goodsdata)



}



func Getdatafromserverofweek(c *gin.Context){
  var goodsdata []Goodsofweek
  db.Order("date").Find(&goodsdata)
  db.Find(&goodsdata)
  c.JSON(200, gin.H{
   "goodsdata": goodsdata,
   "message": "u have uploaded info,please come on!",
 })

}






func getweekday(datestring string) []string {	
  layout := "2006-01-02"
  //str := "2019-03-19"
  t, err := time.Parse(layout, datestring)
  
  if err != nil {
      fmt.Println(err)
  }
  fmt.Println(t)
  
  weekday := t.Weekday()
  fmt.Println(weekday)      // "Tuesday"
  fmt.Println(int(weekday)) 
  var count = int(weekday)-1
  if int(weekday) ==0{count=6}
  var daterange []string
  t = t.AddDate(0, 0, -count)	
  for i := 0; i < 7; i++ {
  daterange = append(daterange,t.AddDate(0, 0, i).Format("2006-01-02"))		
  }
  
  fmt.Println(daterange) 
  return daterange
  }


  func getmonthday(datestring string) []string {	
    layout1 := "2006-01-02"
    // //str := "2019-03-19"
    // t1, err := time.Parse(layout1, datestring)
  
    // if err != nil {
    //     fmt.Println(err)
    // }
    // fmt.Println(t1)
  
  
  
    //       fmt.Println("Hello, playground")
     //layout := "2010-04-06"
    //str := "2019-03-19"
  //layout := "2006-01-02"
    t, err := time.Parse(layout1,datestring)
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









func (t Goods) updateweekdata(){
  dateweek := getweekday(t.Date)
  var goodsweek []Goods
  fmt.Println(t)
  for i:=0;i<len(dateweek);i++{
    datefromweb := dateweek[i]
    fmt.Println(dateweek)
    var goodsofsingleday Goods
    db.Where("date =  ?", datefromweb).Find(&goodsofsingleday)
    fmt.Println(goodsofsingleday)
    if goodsofsingleday.Date == datefromweb {
      goodsweek = append(goodsweek,goodsofsingleday)
    }
    //select * from goods wheere date = date1
  }

  fmt.Println("++++++++++++++=test database++++++++++++++++")
  fmt.Println(goodsweek)

  volume := 0.0
  low := 10000.0
  high := 0.0
  open := goodsweek[0].Open
  close := goodsweek[len(goodsweek)-1].Close
  for i:=0;i<len(goodsweek);i++{
      volume = volume + goodsweek[i].Volume  
      if  goodsweek[i].Highest > high{ high = goodsweek[i].Highest }
      if  goodsweek[i].Lowest < low { low = goodsweek[i].Lowest}
  }
date:= goodsweek[0].Date
fmt.Println("++++++++++++++=test date++++++++++++++++")
fmt.Println(date)
dataforweektodb := Goodsofweek{Date:date,Lowest:low,Highest:high,Open:open,Close:close,Volume:volume}
fmt.Println(dataforweektodb)
var dataforweek Goodsofweek
var countforgoodsofweeks = 0 
db.Where("date =  ?", date).Find(&dataforweek).Count(&countforgoodsofweeks)
if countforgoodsofweeks >0{db.Model(&dataforweek).Updates(dataforweektodb)}
if countforgoodsofweeks ==0{db.Create(&dataforweektodb)}
}


func (t Goods) updatemonthdata(){
  datemonth := getmonthday(t.Date)
  var goodsmonth []Goods
  fmt.Println(t)
  for i:=0;i<len(datemonth);i++{
    datefromweb := datemonth[i]
    fmt.Println(datemonth)
    var goodsofsingleday Goods
    db.Where("date =  ?", datefromweb).Find(&goodsofsingleday)
    fmt.Println(goodsofsingleday)
    if goodsofsingleday.Date == datefromweb {
      fmt.Println("++++++++++++++=test database++++++++++++++++")
      fmt.Println(goodsofsingleday)
      fmt.Println(datefromweb)
      goodsmonth = append(goodsmonth,goodsofsingleday)
    }
    //select * from goods wheere date = date1
  }

  fmt.Println("++++++++++++++=test database++++++++++++++++")
  fmt.Println(goodsmonth)

  volume := 0.0
  low := 10000.0
  high := 0.0
  open := goodsmonth[0].Open
  close := goodsmonth[len(goodsmonth)-1].Close
  for i:=0;i<len(goodsmonth);i++{
      volume = volume + goodsmonth[i].Volume  
      if  goodsmonth[i].Highest > high{ high = goodsmonth[i].Highest }
      if  goodsmonth[i].Lowest < low { low = goodsmonth[i].Lowest}
  }
date:= goodsmonth[0].Date
fmt.Println("++++++++++++++=test date++++++++++++++++")
fmt.Println(date)
dataformonthtodb := Goodsofmonth{Date:date,Lowest:low,Highest:high,Open:open,Close:close,Volume:volume}
fmt.Println(dataformonthtodb)
var dataformonth Goodsofmonth
var countforgoodsofmonth = 0 
db.Where("date =  ?", date).Find(&dataformonth).Count(&countforgoodsofmonth)
if countforgoodsofmonth >0{db.Model(&dataformonth).Updates(dataformonthtodb)}
if countforgoodsofmonth ==0{db.Create(&dataformonthtodb)}
}






func Recorddatafromweb(c *gin.Context){
   note := c.Query("note")
   goodsname := c.Query("goodsname")
   highest := c.Query("highest")
   highest_f,_ := strconv.ParseFloat(highest, 64)
   date := c.Query("date")
   var singlegoods  Goods
   var countforgoods int
   db.Where("date =  ?", date).Find(&singlegoods).Count(&countforgoods)
   if (countforgoods >0){
     fmt.Println("----------what happend-----------------")
    c.JSON(200, gin.H{
      "status":  "201",
      "message": "请不要重复上传!",
    })
    return
   }
   lowest := c.Query("lowest")
   lowest_f,_ := strconv.ParseFloat(lowest, 64)
   open :=  c.Query("open")
   open_f,_ := strconv.ParseFloat(open, 64)
   close :=  c.Query("close")
   close_f,_ :=  strconv.ParseFloat(close,64)
   volume :=  c.Query("volume")
   volume_f,_ :=  strconv.ParseFloat(volume, 64)
   goods := Goods{Goodsname:goodsname,Note:note,Date:date,Highest:highest_f,Lowest:lowest_f,Open:open_f,Close:close_f,Volume:volume_f}
   db.Save(&goods)
   goods.updateweekdata()
   goods.updatemonthdata()
   c.JSON(200, gin.H{
    "status":  "posted",
    "message": "u have uploaded info,please come on!",
  })

}


