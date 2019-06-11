//
//  NewsfeedInteractor.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 11/06/2019.
//  Copyright (c) 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
  }
  
}
