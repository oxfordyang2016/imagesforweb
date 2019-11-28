//
//  ToDoIntentHandler.swift
//  gtdv1.0
//
//  Created by RCY-FUDAN on 2019/10/24.
//  Copyright © 2019 DAMING GROUP. All rights reserved.
//



import Foundation
import Intents
import Alamofire
import SwiftyJSON
import SQLite
protocol intentdata {
 
    func createsimepletask(task:String)
}







var database_siri:Connection!
let userstable_siri = Table("users")
let id_siri = Expression<Int64>("id")
let dbpassword_siri = Expression<String>("password")
let dbemail_siri = Expression<String>("email")
let status_siri = Expression<String>("status")
func accessdbtogetemail()-> String{
                var parameters1:Parameters
                var email =  "yang756260386@gmail.com"
                print("---------i had execute in there--------------")
                do{
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileurl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
                    let db = try Connection(fileurl.path)
                    print(fileurl.path)
                    database_siri =  db
                }catch{
                    print("data not sexit")
                }

                //let users = try database.prepare(userstable)
                //database = try Connection("users.sqlite3")
                if database_siri == nil {print("it is empty")

                }
    //            catch{
    //                print(error)
    //                print("i have some error in look up db+++++++++++++++")
    //                // performSegue(withIdentifier:"showlogin", sender: self )
    //
    //            }
                //let users =   try database.prepare(userstable)
                do {

                    print("---------query database------------")
                    let users =  try database_siri.prepare(userstable_siri)
                    print(users)
                    print("++++++++yangming++++++")
                    for user in users{print("id: \(user[id_siri]), dbpassword: \(user[dbpassword_siri]), email: \(user[dbemail_siri])")
                        //parameters1 = ["email":user[dbemail],"password":user[dbpassword],"client":"commandline"]
                        //the next line is for debug,u need to change to the above line
                        print(user)
                        if user[id_siri]==1{
                          email = user[dbemail_siri]

                        parameters1 = ["email":user[dbemail_siri],"password":user[dbpassword_siri],"client":"commandline"]
                        print(parameters1)
//                        Alamofire.request(globalurl+"/login",method: .post, parameters: parameters1).responseJSON {
//                            response in
//
//                            print("---------requests had send------------")
//                            print("Request: \(String(describing: response.request))")   // original url request
//                            print("Response: \(String(describing: response.response))") // http url response
//                            //print(request?.allHTTPHeaderFields)
//                            // response serialization result
//                            if "\(response.result)"=="SUCCESS"{
//                                // self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
//                                print("u have upload successfully")
//                                //self.performSegue(withIdentifier: "gohome", sender: nil)
//                                userstatus = "logined"}}
//
                        }
                     }
    //                // parameters1 = ["email":user[dbemail],"password":user[dbpassword],"client":"commandline"]


                }
                catch{
                    print("+++++++++there is someerror in query table+++++++++")

//                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "video") as UIViewController
//                    self.window = UIWindow(frame: UIScreen.main.bounds)
//                    self.window?.rootViewController = initialViewControlleripad
//                    self.window?.makeKeyAndVisible()

                    print(error)
                }

return email
//            return true
}





class ToDoIntentHandler : NSObject, ToDoIntentHandling {
//    var globalurl = "http://106.54.84.98:8081/v1"
    var globalurl = "https://www.blackboxo.top/v1"
    var rooturl = "https://www.blackboxo.top"
    var task = ""
    var tag = ""
    var plantime = "today"
    var  intentdelegate: intentdata?
//    var email_from_db = accessdbtogetemail()
//    func resolveTime(for intent: ToDoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let time = intent.time else {
//                        completion(INStringResolutionResult.needsValue())
//                        return
//                    }
//                    completion(INStringResolutionResult.success(with: time))
//    }
    
    
    func  getreviewalgodata_for_siri(email:String)->String{
        var status_lock =  -0.1
        var result_for_siri =  "数据获取不成功，请稍后再试"
        let header:HTTPHeaders = ["client":"ios","email":email]
            Alamofire.request(globalurl+"/reviewdaydatajson",method: .get,headers:header).responseJSON {
                response in
                //print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                //print("Result: \(response.result)")                         // response serialization result
                if "\(response.result)"=="SUCCESS"{
                    //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                    //print("work")
                }
                if let json = response.result.value {
                    ////print("JSON: \(json)") // serialized json response
                    //print(type(of: json))
                }
                
                let result1 = response.result
                //taskdictfottest = (result.value as? Dictionary<String,AnyObject>)!
                var result = response.result.value
                var resultforreviewalgorithm = JSON(result)
               print("--------------------")
                 var allscore = resultforreviewalgorithm["reviewdata"].array
                var totalscore_latest30days = [String]()
                for  index in allscore ?? []{
                
                    var detail = self.convertToDictionary(text:index["details"].stringValue)
    //                print(detail?["totalscore"] as! Float64)
                    if detail?["totalscore"] != nil{
                       print(detail?["totalscore"] as! Float64)
                totalscore_latest30days.append(String(format: "%.2f",detail?["totalscore"] as! Float64))
                    }
                }
                totalscore_latest30days.reverse()
                result_for_siri = "你最近三十天的表现数据为\(totalscore_latest30days)"
    //            alltoalscore = [ast.literal_eval(k["details"])["totalscore"] for k in resultforreviewalgorithm]
                status_lock = 0.1
                //print(result)
        }
        
        while status_lock < 0{
            print("iam here")
        }
           
           return  result_for_siri
        
        
        }
        
    
    
    
    
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    struct Task{
        var ID:Int64 = 0
        var AccurateFinishtime:String = ""
        var Latitude:String = ""
        var Longitude:String = ""
        var email:String = ""
        var finishtime:String = ""
        var ifdissect:String = ""
        var note:String = ""
        var place:String = ""
        var plantime:String = ""
        var project:String = ""
        var status:String = ""
        var task:String = "no task show"
        var user:String = ""
        var reviewdata:[String:String]=[:]
        var tasktags:[String:String] = [:]
        var goal:String = ""
        var devotedtime:Int = 0
        var priority:Int = 0
    }

    
    
    
    struct Plan{
        //https://stackoverflow.com/questions/40554009/swift-make-arrays-of-structs
        var Name:String = "noproject"
        var Alltasksinaday:[Task] = []
    }
    
    var plans:[Plan] = []
    func  requestsever()->[Plan]{
        
        self.plans.removeAll()//u need to note the lifecycle of view such as viewdidload
        
        let defaults = UserDefaults(suiteName: "group.userscontainer")
//我们这里return很奇怪
        guard let email = defaults?.string(forKey: "email") else { return []}
        let headers: HTTPHeaders = [
            "email":email,
            "client": "ios"
        ]
        
        let startforrequests = DispatchTime.now()
        
        Alamofire.request(globalurl+"/everyday",method: .get,headers: headers).responseJSON {
            response in
            if "\(response.result)"=="SUCCESS"{
                //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                let endforrequests = DispatchTime.now()
                let nanoTime = endforrequests.uptimeNanoseconds - startforrequests.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                
                print("Time interval from requests +\(timeInterval) seconds")
                print("work")
            }else{
                print("request not work")
                return
            }
            if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                print(type(of: json))
            }
            let result = response.result.value
            let plansofsever = JSON(result)
            let start = DispatchTime.now()
            var countforproject = 0
            var countformemory = 0
            //https://stackoverflow.com/questions/40168217/parsing-jsonarray-to-string-array-using-swiftyjson  performance up!!!!
            var allplans =  plansofsever["plans"].array
            print(allplans)
            if "\(allplans)" != "nil"{
            for eachday in allplans!{
                var tasksfordatasource:[Task] = []
                var dayname = eachday["Name"].stringValue
                var tasks = eachday["Alldays"].array
                for certaintask in tasks!{
                    print(certaintask["task"].stringValue)
                    var reviewdata = certaintask["reviewdatas"].stringValue as! String
                    var reviewdatadict:[String:String] = [:]
                    if reviewdata==""{
                        reviewdatadict = [:]
                    }else{
                        reviewdatadict = self.convertToDictionary(text: reviewdata) as! [String : String]
                    }
                    let taskinaday = Task(ID: Int64(certaintask["ID"].int as! Int), AccurateFinishtime: certaintask["AccurateFinishtime"].stringValue ,
                                          Latitude: certaintask["Latitude"].stringValue, Longitude: certaintask["Longitude"].stringValue, email: certaintask["email"].stringValue as! String, finishtime: certaintask["finishtime"].stringValue as! String, ifdissect: certaintask["ifdissect"].stringValue as! String, note: certaintask["note"].stringValue as! String, place: certaintask["place"].stringValue as! String, plantime: certaintask["plantime"].stringValue as! String, project: certaintask["project"].stringValue as! String, status: certaintask["status"].stringValue as! String, task: certaintask["task"].stringValue as! String, user: certaintask["user"].stringValue,reviewdata:reviewdatadict,tasktags:[:],goal:certaintask["goal"].stringValue as! String,devotedtime:certaintask["devotedtime"].int ?? 0,priority:certaintask["priority"].int ?? 0 )
                    tasksfordatasource.append(taskinaday)
                    tasksfordatasource.sort{$0.priority>$1.priority}
                }
                self.plans.append(Plan(Name:dayname, Alltasksinaday:tasksfordatasource))
            }
            }
                let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
            print("Time from memories +\(timeInterval) seconds")
        }
        while plans.count == 0{
            sleep(1)
        }
        
        return plans
        //self.pridetableview.reloadData()
        
    }
    
    
    
    
    func  request_review_score()->String{
         let defaults = UserDefaults(suiteName: "group.userscontainer")
        guard let email = defaults?.string(forKey: "email") else { return "yang7@gmail.com" }
        print("------------")
        print(email)
         let headers: HTTPHeaders = [
             "email":email,
             "client": "ios"
         ]
         
         let startforrequests = DispatchTime.now()
        var score  = -0.001
         Alamofire.request(globalurl+"/reviewscoreoftoday",method: .get,headers: headers).responseJSON {
             response in
             if "\(response.result)"=="SUCCESS"{
                 //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                 let endforrequests = DispatchTime.now()
                 let nanoTime = endforrequests.uptimeNanoseconds - startforrequests.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                 let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                 
                 print("Time interval from requests +\(timeInterval) seconds")
                 print("work")
             }else{
                 print("request not work")
                 return
             }
             if let json = response.result.value {
                 //print("JSON: \(json)") // serialized json response
                 print(type(of: json))
             }
             let result = response.result.value
             let review = JSON(result)
    //https://stackoverflow.com/questions/40168217/parsing-jsonarray-to-string-array-using-swiftyjson  performance up!!!!
            score =  review["score"].double ?? -0.001
          score = Double(String(format: "%.3f", score))!
            
//            String(format: "%.2f",detail?["totalscore"] as! Float64)
         }
        while score == -0.001{
             sleep(1)
         }
         
         return "主人评价算法的分数是\(score)"
         //self.pridetableview.reloadData()
         
     }
     
// 获取每一天的summary
     func  requestsever_review_text(url:String,time:String)->String{
         //print("++++++===============i am here++++++++do some request++++++++++++++")
         var review_text = "god"
        let defaults = UserDefaults(suiteName: "group.userscontainer")
          guard let email = defaults?.string(forKey: "email") else { return "yang"}
        let header:HTTPHeaders = ["client":"ios","email":email]
         Alamofire.request(url,method: .get,headers:header).responseJSON {
             response in
             //print("Request: \(String(describing: response.request))")   // original url request
             //print("Response: \(String(describing: response.response))") // http url response
             //print("Result: \(response.result)")                         // response serialization result
             if "\(response.result)"=="SUCCESS"{
                 //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                 //print("work")
             }
             if let json = response.result.value {
                 ////print("JSON: \(json)") // serialized json response
                 //print(type(of: json))
             }
             
             let result1 = response.result
             //taskdictfottest = (result.value as? Dictionary<String,AnyObject>)!
             var result = response.result.value
              var server_result = JSON(result)
             //var  alltasks_fromserver:[SwiftyJSON.JSON]?
             print(server_result)
             let days:Int = server_result["dayscount"].int ?? 11
             print(days)
             let taskfinished_count:Int = server_result["alltasks_count"].int ?? 111
             let  plannedtask_same_with_finished_today_count:Int = server_result["plannedtask_same_with_finished_today_count"].int ?? 111
             let  planned_task_count:Int = server_result["today_planed_task_count"].int ?? 111
             let devotedtime:Int = server_result["devotedtime"].int ?? 111
             let devotedtime_oriented:Int = server_result["devotedtime_oriented"].int  ?? 111
             let  goal_devotedtime = JSON(server_result["goaltime"]).dictionaryObject
             
             let reviewalgo  = server_result["reviewdata"].array
             //let goal_devotedtime:Int = server_result["goaltime"].int ?? 111
             var chinese_time = ""
             if time == "today"{chinese_time = "今天"}
             if time == "yesterday"{chinese_time = "昨天"}
            if time == "week"{chinese_time = "本周"}
             let summary = "你已经在\(String(describing: chinese_time))完成了\(taskfinished_count)个任务，其中你计划完成\(planned_task_count)个任务，但是你你完成了计划任务中的\(plannedtask_same_with_finished_today_count)项，你在这些天中投入的时间为\(String(describing: devotedtime))分钟，在这些时间里你有\(String(describing: devotedtime_oriented))分钟是为你的目标完成的。"
             var timeforeverygoal = ""
             for (goal,time) in goal_devotedtime ?? [:]{
                 timeforeverygoal = timeforeverygoal + "你为的\(goal)目标投入\(time) 分钟。"
             }
             //sttistics  for reviewalgo
             var   accept_pain_count  = 0
             var use_principle_count = 0
             var usebrain_count = 0
             var  immediately_mark = 0
             var battlelowerbrain_count = 0
             var attackactively_times = 0
             var atomadifficulttask_times = 0
             var learnnewthings_times  = 0
             var patience_count = 0
             var alwaysprofit_count = 0
             var buildframeandprinciple_times  = 0
             var difficultthings_times  = 0
             var threeminutes_principle_count = 0
             var learntechuse_count = 0
             var challengethings_count = 0
             var conquerthefear_count = 0
             var setarecord_count = 0
             for  index in reviewalgo ?? []{
                  conquerthefear_count = conquerthefear_count + index["conquerthefear"].intValue as! Int
                  
                setarecord_count = setarecord_count + index["setarecord"].intValue as! Int
                

                
                
                learntechuse_count = learntechuse_count + index["learntechuse"].intValue as! Int
                 threeminutes_principle_count = threeminutes_principle_count + index["threeminutes"].intValue as! Int
                difficultthings_times = difficultthings_times + index["difficultthings"].intValue as! Int
                accept_pain_count = accept_pain_count + index["acceptpain"].intValue as! Int
                use_principle_count = use_principle_count + index["useprinciple"].intValue
                  usebrain_count = usebrain_count + index["usebrain"].intValue as! Int
                  immediately_mark = immediately_mark + index["markataskimmediately"].intValue as! Int
                 battlelowerbrain_count = battlelowerbrain_count + index["battlewithlowerbrain"].intValue as! Int
                 attackactively_times = attackactively_times + index["attackactively"].intValue as! Int
                atomadifficulttask_times = atomadifficulttask_times + index["atomadifficulttask"].intValue
                learnnewthings_times = learnnewthings_times + index["learnnewthings"].intValue
                patience_count = patience_count + index["patiencenumber"].intValue
                alwaysprofit_count = alwaysprofit_count + index["alwaysprofit"].intValue
                buildframeandprinciple_times = buildframeandprinciple_times + index["buildframeandprinciple"].intValue
             }
             var reviewalgo_times = "完成困难的事情\(difficultthings_times)件，完成有挑战的事情\(challengethings_count)件，战胜内心的恐惧\(conquerthefear_count)次，你接受痛苦\(accept_pain_count)次.使用原则\(use_principle_count)次，破纪录\(setarecord_count)次,动脑经\(usebrain_count)次，立即标记任务\(immediately_mark)次，战胜低级情绪\(battlelowerbrain_count)次，主动进攻\(attackactively_times)次，原子化拆分复杂任务\(atomadifficulttask_times)次，使用学习技术\(learntechuse_count)次，保持耐心\(patience_count)次，学到新东西\(learnnewthings_times)次，总是保持获利\(alwaysprofit_count)次。建立知识框架和原则\(buildframeandprinciple_times)次,使用三分钟原则\(threeminutes_principle_count)次"
//             if time == "today"{self.todaystatistics.text = summary + timeforeverygoal+reviewalgo_times}
//             if time == "yesterday"{
//                 self.yesterdaystatistics.text = summary + timeforeverygoal+reviewalgo_times
//             }
           review_text =  summary + timeforeverygoal+reviewalgo_times+"。报告完毕，主人加油，平庸的生活是毫无意义的"
             print(result)
         }
        while review_text == "god"{
            sleep(1)
        }
       
         return review_text
     }
    
    
    
    
    
    
    
    
    // 获取每一天的summary
         func  requestsever_fees(url:String,time:String)->String{
             //print("++++++===============i am here++++++++do some request++++++++++++++")
                    let defaults = UserDefaults(suiteName: "group.userscontainer")
                   guard let email = defaults?.string(forKey: "email") else {
                    
                    return "账户设置错误" }
                   print("------------")
                   print(email)
                    let headers: HTTPHeaders = [
                        "email":email,
                        "client": "ios"
                    ]
                    
                    let startforrequests = DispatchTime.now()
                   var cost  = -0.001
            var  income = -0.001
                    Alamofire.request(url,method: .get,headers: headers).responseJSON {
                        response in
                        if "\(response.result)"=="SUCCESS"{
                            //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                            let endforrequests = DispatchTime.now()
                            let nanoTime = endforrequests.uptimeNanoseconds - startforrequests.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                            
                            print("Time interval from requests +\(timeInterval) seconds")
                            print("work")
                        }else{
                            print("request not work")
                            return
                        }
                        if let json = response.result.value {
                            //print("JSON: \(json)") // serialized json response
                            print(type(of: json))
                        }
                        let result = response.result.value
                        let review = JSON(result)
               //https://stackoverflow.com/questions/40168217/parsing-jsonarray-to-string-array-using-swiftyjson  performance up!!!!
                       cost =  review["cost"].double ?? -0.001
                       cost = Double(String(format: "%.3f", cost))!
                       income =  review["income"].double ?? -0.001
                            income = Double(String(format: "%.3f", income))!
                        
           //            String(format: "%.2f",detail?["totalscore"] as! Float64)
                    }
                   while cost == -0.001{
                        sleep(1)
                    }
                    var time_c = "昨天"
            if time=="yesterday"{
                time_c = "昨天"
            }
            if time=="today"{
                           time_c = "今天"
                       }
            if time=="thisweek"{
                                   time_c = "本周"
                               }
            
            return "主人你\(time_c)的财务报告如下,你的收入为\(income)元.你一共消费了\(cost)元,报告完毕"
                    //self.pridetableview.reloadData()
         }
        
    
    
    
    
    
    
    
    
        func searchwithtag(email:String,tasktag:String) ->String{
            let header:HTTPHeaders = ["client":"ios","email":email]
    
//            let parameters1: Parameters=[
//                       ]
                               

                var status_end = 0
                var result = "主人你的任务如下"
                                       print("++++++++++++creat task+++++++++++++++++")
            Alamofire.request("https://www.blackboxo.top"+"/v1/searchwithtag?keywords="+tasktag,method: .get,  encoding: JSONEncoding.default, headers:header).responseJSON {
                                   response in
    //
                let status = response.response?.statusCode
                if status != 200{
                    result = "主人获取任务失败，请稍后再试。"
                    status_end = -1
                }
                                   print("Request: \(String(describing: response.request))")   // original url request
                                   print("Response: \(String(describing: response.response))") // http url response
                                   print("Result: \(response.result)")                         // response serialization result
                                print("\(response.result)")
                                   if "\(response.result)"=="SUCCESS"{
                                       //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                                    print("-----test------")
                                   }else{
                                    print("我去买圣代")
                                 }
                
                var resultfromserver = response.result.value
                       let tasksofsever = JSON(resultfromserver)

                       var countforproject = 0
                       var countformemory = 0
                       //https://stackoverflow.com/questions/40168217/parsing-jsonarray-to-string-array-using-swiftyjson  performance up!!!!
                       var alltasks =  tasksofsever["search"].array
                       
                       if "\(alltasks)" != "nil"{
                        var tagged_tasks:[String] = []
                    
                        for certaintask in alltasks!{
                            var task = certaintask["task"].stringValue
                               print(certaintask["task"].stringValue)
                            tagged_tasks.append(certaintask["task"].stringValue)
                            result = result + ",\(task)"
                       }
//                        这里表示获取数据成功
                        status_end = 1
                       }
            
            
            }
            
            while status_end == 0{
             sleep(1)
            }
            
            return result
                               
           }
    
    
    
    
    
    
    
    
    
    func createfee(task: String,email:String,direction:String,date:String) ->String{
        let header:HTTPHeaders = ["client":"ios","email":email]
        print(task,direction,date)
        let parameters1: Parameters=[
                            
                                   "direction":direction,
                                    "inbox":task,
                                    "date":date
                                                         
                
                   ]
                           

            var status_end = 0
            var result = "没有记账成功,请重新记录"
                                   print("++++++++++++creat task+++++++++++++++++")
        Alamofire.request("https://www.blackboxo.top"+"/finance/uploadfees",method: .post, parameters: parameters1, encoding: JSONEncoding.default, headers:header).responseJSON {
                               response in
//
            let status = response.response?.statusCode
            if status == 200{
                status_end = 1
             result = "记账成功"
                print(status)
            }else{
                status_end = -1
            }
                               print("Request: \(String(describing: response.request))")   // original url request
                               print("Response: \(String(describing: response.response))") // http url response
                               print("Result: \(response.result)")                         // response serialization result
                            print("\(response.result)")
                               if "\(response.result)"=="SUCCESS"{
                                   //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                                print("-----test------")
                               }else{
                                print("我去买圣代")
            }
                               if let json = response.result.value {
                                   print("JSON: \(json)") // serialized json response
                                   
                               }
                           
                           }
        
        while status_end == 0{
         sleep(1)
        }
        
        return result
                           
       }
       
    
    
    
    
    
    func resolveTag(for intent: ToDoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let tag = intent.tag else {
                  completion(INStringResolutionResult.needsValue())
                  return
              }
              completion(INStringResolutionResult.success(with: tag))
    }
//
    func resolveTask(for intent: ToDoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let task = intent.task else {
              completion(INStringResolutionResult.needsValue())
              return
          }
          completion(INStringResolutionResult.success(with: task))
    }
    
 
    
//    func resolveTag(for intent: ToDoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let time = intent.time else {
//              completion(INStringResolutionResult.needsValue())
//              return
//          }
//          completion(INStringResolutionResult.success(with: time))
//    }
    
    
       
        func  getreviewalgodata(){
//            var email = accessdbtogetemail()
            let header:HTTPHeaders = ["client":"ios"]
            Alamofire.request(globalurl+"/reviewdaydatajson",method: .get,headers:header).responseJSON {
                response in
                //print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                //print("Result: \(response.result)")                         // response serialization result
                if "\(response.result)"=="SUCCESS"{
                    //self.uploadstatus.text =  "have uploaded sucessfully,please come on!"
                    //print("work")
                }
                if let json = response.result.value {
                    ////print("JSON: \(json)") // serialized json response
                    //print(type(of: json))
                }
                
                let result1 = response.result
                //taskdictfottest = (result.value as? Dictionary<String,AnyObject>)!
                var result = response.result.value
                var resultforreviewalgorithm = JSON(result)
               print("--------------------")
                print(resultforreviewalgorithm)
//                 var allscore = resultforreviewalgorithm["reviewdata"].array
//                var totalscore_latest30days = [String]()
//                for  index in allscore ?? []{
//
//                    var detail = convertToDictionary(text:index["details"].stringValue)
//    //                print(detail?["totalscore"] as! Float64)
//                    if detail?["totalscore"] != nil{
//                       print(detail?["totalscore"] as! Float64)
//                totalscore_latest30days.append(String(format: "%.2f",detail?["totalscore"] as! Float64))
//                    }
//                }
//                totalscore_latest30days.reverse()
//                self.reviewalgodata.text = "你最近三十天的表现数据为\(totalscore_latest30days)"
    //            alltoalscore = [ast.literal_eval(k["details"])["totalscore"] for k in resultforreviewalgorithm]
               
                //print(result)
        }
        
        
        
        }
        
    
    
    
    
    
    func handle(intent: ToDoIntent, completion: @escaping (ToDoIntentResponse) -> Void) {
        let algovalue_from_server = addTODO(task: intent.task!,tag:intent.tag!)
        completion(ToDoIntentResponse.success(result:algovalue_from_server))
        print("--------here-------")
    }
    
    //implement this method to get the to-do list from UserDefaults, add to it, save it again to user defaults

    func today_string() -> String{
        let now = Date()
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        //DateFormatter对象的string方法执行转换(参数now为之前代码中所创建)
        var convertedDate0 = dateFormatter.string(from: now)
        //输出转换结果
        //print("\(convertedDate0)")//发现输出的是："\n"
        //设置时间格式（这里的dateFormatter对象在上一段代码中创建）
        dateFormatter.dateFormat = "yyyyMMdd"
        //调用string方法进行转换
        convertedDate0 = dateFormatter.string(from: now)
        var final_time = "\(convertedDate0)"
        //输出转换结果

        print(final_time)//结果为：2018-01-11 11:45:30\n
        //获取子字符串
        //let s = "www.stackoverflow.com"
        let s = final_time
        //let start = s.startIndex
        let start = s.index(s.startIndex, offsetBy: +2)
        //let end = s.index(s.endIndex, offsetBy: -4)
        let end = s.endIndex
        let substring = s[start..<end] // www.stackoverflow
        print(substring)
        return String(substring)
    }






   func yesterday_string() -> String{
       var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day) // -1 day

        let now = Date() // Current date
       guard let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) else { return "yesterday" } // Add the
       let formatter = DateFormatter()
       // initially set the format based on your datepicker date / server String
       formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       let myString = formatter.string(from: Date()) // string purpose I add here
       // convert your string to date
       let yourDate = formatter.date(from: myString)
       //then again set the date format whhich type of output you need
       formatter.dateFormat = "yyMMdd"
       // again convert your date to string
       let myStringafd = formatter.string(from: yesterday)
       return myStringafd
   }

    

    
    
    func yesterday() -> Date {

       var dateComponents = DateComponents()
       dateComponents.setValue(-1, for: .day) // -1 day

       let now = Date() // Current date
       let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) // Add the DateComponents

       return yesterday!
    }
    
    
    
//下面这个函数是去解释来自Siri的命令
    func addTODO(task: String,tag:String) -> String{
    
        
        
        
        var result = "无聊的人生是非常悲凉的"
        
        if task.contains("算法的结果"){
              let result =  request_review_score()
              print(result)
              return result
              }
        
        if task.contains("今天的评价报告"){
            let result = self.requestsever_review_text(url: globalurl+"/reviewfortimes?days=1",time: "today")
              print(result)
              return result
              }
        
        
        if task.contains("最近的表现"){
            let defaults = UserDefaults(suiteName: "group.userscontainer")
              guard let email_siri = defaults?.string(forKey: "email") else { return "not work"}
            let result = self.getreviewalgodata_for_siri(email:email_siri)
              print(result)
              return result
              }
        
        
        
        
        
        
        if task.contains("昨天的评价报告"){
                 let result = self.requestsever_review_text(url: globalurl+"/reviewfortimes?days=-1",time: "yesterday")
                  print(result)
                  return result
                  }
       
        
        if task.contains("本周的评价报告"){
                 let result = self.requestsever_review_text(url: globalurl+"/reviewfortimes?days=7",time: "week")
                  print(result)
                  return result
                  }

        if task.contains("昨天的财务报告"){
                 let result = self.requestsever_fees(url: rooturl+"/finance"+"/statistics?days=-1",time: "yesterday")
                  print(result)
                  return result
                  }
        
        
        if task.contains("今天的财务报告"){
                 let result = self.requestsever_fees(url: rooturl+"/finance"+"/statistics?days=0",time: "today")
                  print(result)
                  return result
                  }
        
        
        
        
        
        if task.contains("紧急的任务"){
            let defaults = UserDefaults(suiteName: "group.userscontainer")
                                //我们这里return很奇怪
                       guard let email = defaults?.string(forKey: "email") else { return "not work"}
            let result = self.searchwithtag(email:email,tasktag:"urgenttag")
                  print(result)
                  return result
                  }
 
        if task.contains("花了"){
            var  task = task.replacingOccurrences(of: "十", with: "10", options: .literal, range: nil)
            task = task.replacingOccurrences(of: "九", with: "9", options: .literal, range: nil)
             task = task.replacingOccurrences(of: "八", with: "8", options: .literal, range: nil)
            task = task.replacingOccurrences(of: "七", with: "7", options: .literal, range: nil)
    task = task.replacingOccurrences(of: "六", with: "6", options: .literal, range: nil)
              task = task.replacingOccurrences(of: "五", with: "5", options: .literal, range: nil)
              task = task.replacingOccurrences(of: "四", with: "4", options: .literal, range: nil)
              task = task.replacingOccurrences(of: "三", with: "3", options: .literal, range: nil)
              task = task.replacingOccurrences(of: "二", with: "2", options: .literal, range: nil)
              task = task.replacingOccurrences(of: "一", with: "1", options: .literal, range: nil)
            
               var date = today_string()
               let defaults = UserDefaults(suiteName: "group.userscontainer")
                     //我们这里return很奇怪
            guard let email = defaults?.string(forKey: "email") else { return "not work"}
               if task.contains("昨天"){date = yesterday_string()}
               if tag.contains("昨天"){date = yesterday_string()}
               let result = self.createfee(task: task, email: email, direction:"buy", date: date)
                  print(result)
                  return result
                  }
        if task.contains("今天的任务"){
            var plans = self.requestsever()
            while plans.count == 0{
                print("length not work")
            }
            var result = "主人,你今天的任务有这些"
            for k in plans{
                for (id,task) in k.Alltasksinaday.enumerated(){
                    print(task.task)
                    if id != k.Alltasksinaday.endIndex-1{
                        result =  result+task.task+"。下一条是"
                    }else{
                        result =  result+task.task+"。加油主人！"
                    }
                    
                }
            }
            return result
            }
        
        
//        准备读取数据库，获取用户的用户名，然后伴随请求一起传到后台
        print("-------测试本机是否工作正常--------")
//        intentdelegate?.createsimepletask(task: task)
//       print(task)
//        let url = URL(string: "https://www.blackboxo.top/v1/createtaskfromsiri?task=我们吃过了午饭")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
        var siri_status:String = "unfinished"
        var finish_time = "unspecified"
        if tag.contains("明天"){
            plantime =  "tomorrow"
        }
        
        
        
        if tag.contains("完成"){
            siri_status = "finish"
      let now = Date()
      //创建一个DateFormatter来作为转换的桥梁
//      let dateFormatter = DateFormatter()
//      //DateFormatter对象的string方法执行转换(参数now为之前代码中所创建)
//      var convertedDate0 = dateFormatter.string(from: now)
//
//      //输出转换结果
//      //print("\(convertedDate0)")//发现输出的是："\n"
//      //设置时间格式（这里的dateFormatter对象在上一段代码中创建）
//      dateFormatter.dateFormat = "yyyyMMdd"
//      //调用string方法进行转换
//      convertedDate0 = dateFormatter.string(from: now)
//
//
//      var final_time = "\(convertedDate0)"
//      //输出转换结果
//
//      print(final_time)//结果为：2018-01-11 11:45:30\n

            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyMMdd"
            finish_time = formatter.string(from: currentDate)
            
            if tag.contains("昨天"){
            //                var day = self.yesterday()
                            let formatter = DateFormatter()
                            // initially set the format based on your datepicker date / server String
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                            let myString = formatter.string(from: Date()) // string purpose I add here
                            // convert your string to date
                            let yourDate = formatter.date(from: myString)
                            //then again set the date format whhich type of output you need
                            formatter.dateFormat = "yyMMdd"
                            // again convert your date to string
                            finish_time = formatter.string(from: self.yesterday())
                            plantime = finish_time
                        }
            
            
            
//      //获取子字符串
//      //let s = "www.stackoverflow.com"
//      let s = final_time
//      //let start = s.startIndex
//      let start = s.index(s.startIndex, offsetBy: +2)
//      //let end = s.index(s.endIndex, offsetBy: -4)
//      let end = s.endIndex
//      let substring = s[start..<end] // www.stackoverflow
//      print(substring)
//      finish_time = String(substring)
//            return 3.14
    
        }
        
          let defaults = UserDefaults(suiteName: "group.userscontainer")
        //我们这里return很奇怪
                guard let email = defaults?.string(forKey: "email") else { return "not work"}
        
        //and return its size
        let session = URLSession.shared
        let url = URL(string: globalurl+"/createtaskfromsiri")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue(email, forHTTPHeaderField: "email")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
       var uploadtasktags = ["importanttag": "no", "atomtag": "yes", "hardtag": "no", "easytag": "no", "urgenttag": "no", "challengetag": "no", "uncomfortabletag": "no", "tenminutestasktag": "no", "thirtyminutestasktag": "no", "threeminutestasktag": "no"]
        if tag.contains("紧急的"){
            uploadtasktags["urgenttag"] = "yes"
        }
        if tag.contains("重要的"){
            uploadtasktags["importanttag"] = "yes"
        }
        
        if tag.contains("挑战的"){
            uploadtasktags["challengetag"] = "yes"
        }

         if tag.contains("容易的"){
                   uploadtasktags["easytag"] = "yes"
               }
        
        if tag.contains("困难的"){
                          uploadtasktags["hardtag"] = "yes"
                      }
        
        
//        var uploadtasktags = ["atomdifficulttask":"yes"]
        let json  = ["ifdissect":"no","note":"","timedevotedto_a_task":0,"client":"gtdcli","goalcode":"xxx","goal":"Fight against fate","parentproject":"unspecified","inboxlist":[],"inbox":task,"finishtime":finish_time,"place":"unspecified","project":"inbox","taskstatus":siri_status,"plantime":plantime,"tasktags":uploadtasktags] as [String : Any]
        
        print(siri_status)
    
        var final_score = 0.0
//        let semaphore = DispatchSemaphore(value: 0)
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
//        let semaphore = DispatchSemaphore(value: 0)
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            let str = String(data: data!,encoding: String.Encoding.utf8)
                       print(str)
//            print(data)
            print(response)
           
//            https://medium.com/better-programming/json-parsing-in-swift-2498099b78f
//            let jsonResponse = try JSONSerialization.jsonObject(with:
//            data, options: [])
            
            let serverdata = self.convertToDictionary(text: str ?? "{}")
            print(serverdata)
            if self.plantime == "tomorrow"{
                final_score=0.001
            }else{
                  final_score = serverdata?["score"] as! Double
            }
            print(final_score)
            // Do something...
        print("it work")
           
        }
  
        task.resume()
       

//        getreviewalgodata()
        print("最终获得成绩是\(Float64(final_score))")
        while final_score == 0.0{
//            return Float64(final_score)
            print("最后的成绩是\(final_score)")
        }
        print("计划时间是\(plantime)")
             print("完成时间是\(finish_time)")
     //使用字符串来进行作为最后结果的
         final_score = Double(String(format: "%.3f", final_score))!
        result =  "主人评价算法的分数是\(final_score)"
        return result
    }
}
