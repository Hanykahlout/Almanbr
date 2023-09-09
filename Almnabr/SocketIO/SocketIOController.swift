//
//  SocketIOController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 06/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import Foundation
import SocketIO
import ObjectMapper
class SocketIOController{
    
    private var manager:SocketManager!
    private var socket:SocketIOClient?
    
    
    public static let shard:SocketIOController = {
        return SocketIOController()
    }()
    
    private init(){}
    
    
    func connect(){
        manager = SocketManager(socketURL: URL(string:"https://node.almnabr.com/")!)
        let token =  "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        self.manager.config = SocketIOClientConfiguration(
            arrayLiteral: .connectParams(["Authorization": "test"]),.secure(false) )
        
        let dict =  [ "token" : token]
        manager.defaultSocket.connect(withPayload: dict)
        
        socket = self.manager.defaultSocket
        
        self.manager.connectSocket(socket!, withPayload:dict)
         
        socket!.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
    }
    
    
    func taskHandler(ticketId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_tasks_\(userID)") {data, ack in
            callback(data)
        }
    }
    
    
    func ticketStatus(ticketId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_edit_ticket_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func ticketStatusTimeLine(ticketId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_timeline_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func commentsTicketHandler(ticketId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_comments_\(userID)") { data , ack in
           callback(data)
        }
    }
    
    func commentsTaskHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_task_\(taskId)_comments_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func taskTimeLineHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_task_\(taskId)_timeline_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func taskCheckListsHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_task_\(taskId)_checklists_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    func taskAttachmentsHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        print("The response is  \("ticket_\(ticketId)_task_\(taskId)_attachments_\(userID)")")
        socket?.on("ticket_\(ticketId)_task_\(taskId)_attachments_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    func taskDateHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_task_\(taskId)_task_dates_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    func taskMembersHandler(ticketId:String,taskId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_task_\(taskId)_task_members_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func attachHandler(ticketId:String,userID:String,callback:@escaping (_ data:[Any])->Void){
        socket?.on("ticket_\(ticketId)_attachments_\(userID)") { data , ack in
            callback(data)
        }
    }
    
    
    func isConnected()->Bool{
        print("socket is connected:",socket?.status.active ?? false)
        return socket?.status.active ?? false
    }

    func disconnect(){
        if let socket = socket {
            socket.disconnect()
        }
    }
    
    
}
