//
//  NewsfeedPresenter.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 11/06/2019.
//  Copyright (c) 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
  
  }
  
}
