//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Bennett on 2018-09-07.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
  var app: XCUIApplication!
  
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
       app = XCUIApplication()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        deleteAllMeals()
    }
    
    func testAddMeal() {
    
      addNewMeal(mealName: "Burger", numberOfCalories: 300)
    }
  

  
  func testDeleteMeal() {
    
    deleteMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func testDeleteAllMeals() {
    deleteAllMeals()
  }
  
  func testShowMealDetail() {
    showMeal(mealName: "Burger", numberOfCalories: 300)
    app.navigationBars["Detail"].buttons["Master"].tap()
    
  }
  
  func testAddDeletePerformance() {
    measure {
      addNewMeal(mealName: "Burger", numberOfCalories: 300)
      deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
  }
  
  // Mark: Helper functions
  
  func addNewMeal(mealName:String, numberOfCalories:Int){
    app.navigationBars["Master"].buttons["Add"].tap()
    let addAMealAlert = app.alerts["Add a Meal"]
    let collectionViewsQuery = addAMealAlert.collectionViews
    collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
    
    let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.tap()
    textField.typeText(numberOfCalories.description)
          addAMealAlert.buttons["Ok"].tap()
  }
  
  
  fileprivate func deleteMeal(mealName:String, numberOfCalories:Int){
    let tablesQuery = app.tables
    let celltext = mealName + " - " + numberOfCalories.description
    let burger300StaticText = tablesQuery.staticTexts[celltext]
    if burger300StaticText.exists {
      burger300StaticText.swipeLeft()
      tablesQuery.buttons["Delete"].tap()
    }
  }
  
  fileprivate func deleteAllMeals() {
    let tablesQuery = app.tables
    let total = tablesQuery.staticTexts.count
    for i in (0..<total).reversed(){
      let staticText = tablesQuery.staticTexts.element(boundBy: i)
      staticText.swipeLeft()
      tablesQuery.buttons["Delete"].tap()
    }
  }
  
  func showMeal(mealName:String, numberOfCalories:Int){
    let tablesQuery = app.tables
    let celltext = mealName + " - " + numberOfCalories.description
    let staticText = tablesQuery.staticTexts[celltext]
    if staticText.exists {
      staticText.tap()
      
      //check we are on the detail controller
      XCTAssertEqual(app.staticTexts["detailViewLabel"].label, celltext)
      
    }
  }
}
