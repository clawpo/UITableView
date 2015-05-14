//
//  ViewController.swift
//  S03
//
//  Created by 耿小泰 on 15/5/14.
//  Copyright (c) 2015年 耿小泰. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]
    var leftBtn: UIButton?
    var rightButtonItem: UIBarButtonItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
        self.leftBtn!.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //初始化view
    func initView() {
        self.tableView = UITableView(frame: self.view.frame,style:UITableViewStyle.Plain)
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
    //添加Edit按钮
    func setupLeftBarButtonItem() {
        self.leftBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        self.leftBtn!.frame = CGRectMake(0, 0, 50, 40)
        self.leftBtn?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        self.leftBtn!.tag = 100
        self.leftBtn!.userInteractionEnabled = false
        self.leftBtn?.addTarget(self, action: "leftBarButtonItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
        var barButtonItem = UIBarButtonItem(customView: self.leftBtn!)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    //Edit按钮点击事件
    func leftBarButtonItemClicked() {
        if(self.leftBtn?.tag == 100) {
            self.leftBtn!.tag = 200
            self.tableView?.setEditing(true, animated: true)
            self.leftBtn?.setTitle("Done", forState: UIControlState.Normal)
            self.rightButtonItem!.enabled = false
        } else {
            self.rightButtonItem!.enabled = true
            self.tableView?.setEditing(false, animated: true)
            self.leftBtn?.tag = 100
            self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    //添加Add按钮
    func setupRightBarButtonItem() {
        self.rightButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "rightBarButtonItemClicked")
        self.navigationItem.rightBarButtonItem = self.rightButtonItem
    }
    
    //Add按钮点击事件
    func rightBarButtonItemClicked() {
        var row = self.items.count
        var indexPath = NSIndexPath(forRow: row, inSection: 0)
        self.items.append("WTF")
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    }
    
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    //加载每行数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        var row = indexPath.row as Int
        cell.textLabel?.text = self.items[row]
        return cell
    }
    
    //删除某行
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var index = indexPath.row as Int
        self.items.removeAtIndex(index)
        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    //点击某行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "您选择的是\(self.items[indexPath.row])"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    //允许滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return (UITableViewCellEditingStyle.Delete)
    }
    
    //允许移动某行排序
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //实现排序
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var itemToMove = self.items[sourceIndexPath.row]
        self.items.removeAtIndex(sourceIndexPath.row)
        self.items.insert(itemToMove, atIndex: destinationIndexPath.row)
        
    }

}

