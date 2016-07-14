//
//  ViewController.swift
//  Colgate professor
//
//  Created by DrewZhong on 4/10/16.
//  Copyright © 2016 DrewZhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var name_2:String=""
    var Option:Int=3;
    @IBAction func button(sender: AnyObject) {
        Option=3;

        var name = input.text?.lowercaseString
        let nameArray=name?.componentsSeparatedByString(" ")
        name = name?.stringByReplacingOccurrencesOfString(" ", withString: "-")
        if nameArray!.count>1{
             name_2=String(nameArray![0][nameArray![0].startIndex])+nameArray![1]
        }
        
        getinfo(name!)
        
        if self.Option == 3{

            let url = NSURL(string: "http://www.colgate.edu/facultysearch/FacultyDirectory/\(name_2)")
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                if let content = data{
                    let content_str=NSString(data: content, encoding: NSUTF8StringEncoding)
                    var contentArray1=content_str?.componentsSeparatedByString("</h1><span class='facdesc'><span style='text-transform:uppercase;'>")
                    if contentArray1!.count>1{
                        let contentArray2=contentArray1![1].componentsSeparatedByString("</span></span><div class='facdesc'>")
                        if contentArray2.count>1{
                            let contentArray3=contentArray2[1].componentsSeparatedByString("</div><div class='dir_items'><span class='dirp'>p</span> ")
                            let contentArray4=contentArray3[1].componentsSeparatedByString("</div><div><a class='highlightLink' href=")
                            dispatch_async(dispatch_get_main_queue(), {
                                contentArray3[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                                contentArray2[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                                contentArray4[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                                self.result.text=contentArray2[0]
                                self.result2.text=contentArray3[0]+"\n"+contentArray4[0]
                            })
                        }
              
                    }
                    else{
                        self.result.text="Sorry, cannot find the professor, make sure you type his/her name correct"

                    }
                }
                else {}
            }
            task.resume()
        }
        

    
    }

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getinfo(name:String){
        let url = NSURL(string: "http://www.colgate.edu/facultysearch/FacultyDirectory/\(name)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if let content = data{
                let content_str=NSString(data: content, encoding: NSUTF8StringEncoding)
                var contentArray1=content_str?.componentsSeparatedByString("</h1><span class='facdesc'><span style='text-transform:uppercase;'>")
                if contentArray1!.count>1{
            print("check")
                    let contentArray2=contentArray1![1].componentsSeparatedByString("</span></span><div class='facdesc'>")
                    if contentArray2.count>1{
                        let contentArray3=contentArray2[1].componentsSeparatedByString("                </div><div class='dir_items'><span class='dirp'>p</span> ")
                        let contentArray4=contentArray3[1].componentsSeparatedByString("</div><div><a class='highlightLink' href=")
                        dispatch_async(dispatch_get_main_queue(), {
                            contentArray3[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                            contentArray2[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                            contentArray4[0].stringByReplacingOccurrencesOfString(" ", withString: "")
                            self.result.text=contentArray2[0]
                            self.result2.text=contentArray3[0]+"\n"+contentArray4[0]
                            self.Option=1;
                        })
                    }
                }
                else{
                    self.result.text="Sorry, cannot find the professor, make sure you type his/her name correct"
                }
            }
            else {}
        }
        task.resume()
        
    }

}

