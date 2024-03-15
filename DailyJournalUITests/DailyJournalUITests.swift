//
//  DailyJournalUITests.swift
//  DailyJournalUITests
//
//  Created by Pascal Hintze on 06.03.2024.
//

import XCTest
import SwiftData
import notify

final class DailyJournalUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppStartsWithNavigationBar() {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be a navigation bar when the app launches.")
    }

    func testAppHasBasicButtonsOnLaunch() {
        XCTAssertTrue(app.buttons["Home"].exists, "There should be a Home tabItem")
        XCTAssertTrue(app.buttons["Journals"].exists, "There should be a Journals tabItem")
        XCTAssertTrue(app.buttons["CreateJournal"].exists, "There should be a plus tabItem")
    }
    func testNoIssuesAtStart() {
        XCTAssertEqual(app.collectionViews["JournalList"].cells.count, 0, "There should be 0 journals initially.")
    }

    func testCreatingAndDeletingJournals() {
        app.buttons["Journals"].tap()
        app.buttons["Add Samples"].tap()
        for _ in (0...2).reversed() {
            app.cells.firstMatch.buttons["EditJournal"].tap()
            app.buttons["Delete"].tap()
        }

        XCTAssertEqual(app.collectionViews["JournalList"].cells.count, 3, "There should be 3 rows in the list.")
    }

    func testCreateJournal() {
        app.buttons["CreateJournal"].tap()
        app.textFields["Title"].tap()
        app.typeText("Newly created journal")
        //        app.textFields["Content"].tap()
        //        app.typeText("This is the content")
        app.navigationBars.images["Edit"].tap()
        app.buttons["Custom Date"].tap()

        app.datePickers.buttons["Sunday, 10 March"].tap()
        app.buttons["SetDate"].tap()

        app.buttons["MoodButton"].tap()
        app.popovers.buttons["Bad"].tap()
        app.buttons["Done"].tap()

        app.buttons["Journals"].tap()

        XCTAssertTrue(app.buttons["Newly created journal"].exists,
                      "A new journal with the title 'Newly created journal' should exists.")
    }

    func testEditJournal() {
        app.tabBars["Tab Bar"].buttons["Journals"].tap()
        app.navigationBars["Journals"].buttons["Add Samples"].tap()

        app.collectionViews.buttons.firstMatch.buttons["EditJournal"].tap()
        app.buttons["Edit"].tap()

        app.textFields["Enter title here"].tap()
        app.textFields["Enter title here"].clear()
        app.typeText("New journal title")
        app.navigationBars.buttons["Done"].tap()

        XCTAssertTrue(app.collectionViews.buttons["New journal title"].exists, "The title should now be changed")
    }

    func testReminderTime() {
        app.navigationBars.buttons["Settings"].tap()
        if (app.switches["ReminderToggle"].value as? String == "1") == false {
            app.switches["ReminderToggle"].switches.firstMatch.tap()
        }
        XCTAssertTrue(app.switches["ReminderToggle"].value as? String == "1")

        app.buttons["NotificationTime"].tap()

        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "10")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "30")

        XCTAssertEqual(app.pickerWheels.element(boundBy: 0).value as? String, "10 o’clock")
        XCTAssertEqual(app.pickerWheels.element(boundBy: 1).value as? String, "30 minutes")
    }
}

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Failed to clear text in XCUIElement")
            return
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}
