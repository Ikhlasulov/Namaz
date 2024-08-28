import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Window {
    width: 700
    height: 800
    visible: true
    title: qsTr("Namaz")

    property string currentTime: ""
    property string clockFormat: "12-hour" // Default clock format

    property int currentMethod: 3 // Default method

    property string fajrTime: ""
    property string sunriseTime: ""
    property string dhuhrTime: ""
    property string asrTime: ""
    property string sunsetTime: ""
    property string maghribTime: ""
    property string ishaTime: ""
    property string imsakTime: ""
    property string midnightTime: ""
    property string firstthirdTime: ""
    property string lastthirdTime: ""

    property int utcOffset: 0 // Default UTC offset

    property var timezones: [
        {
          "value": "Dateline Standard Time",
          "abbr": "DST",
          "offset": -12,
          "isdst": false,
          "text": "(UTC-12:00) International Date Line West",
          "utc": [
            "Etc/GMT+12"
          ],
          "cities": ["International Date Line West"]
        },
        {
          "value": "UTC-11",
          "abbr": "U",
          "offset": -11,
          "isdst": false,
          "text": "(UTC-11:00) Coordinated Universal Time-11",
          "utc": [
            "Etc/GMT+11",
            "Pacific/Midway",
            "Pacific/Niue",
            "Pacific/Pago_Pago"
          ],
          "cities": ["Midway", "Niue", "Pago Pago"]
        },
        {
          "value": "Hawaiian Standard Time",
          "abbr": "HST",
          "offset": -10,
          "isdst": false,
          "text": "(UTC-10:00) Hawaii",
          "utc": [
            "Etc/GMT+10",
            "Pacific/Honolulu",
            "Pacific/Johnston",
            "Pacific/Rarotonga",
            "Pacific/Tahiti"
          ],
          "cities": ["Honolulu", "Johnston", "Rarotonga", "Tahiti"]
        },
        {
          "value": "Alaskan Standard Time",
          "abbr": "AKDT",
          "offset": -8,
          "isdst": true,
          "text": "(UTC-09:00) Alaska",
          "utc": [
            "America/Anchorage",
            "America/Juneau",
            "America/Nome",
            "America/Sitka",
            "America/Yakutat"
          ],
          "cities": ["Anchorage", "Juneau", "Nome", "Sitka", "Yakutat"]
        }
        // Add more timezones as needed
    ]

    property string currentTimezone: timezones[0].text // Default to the first timezone
    property string currentUtc: timezones[0].utc[0] // Default to the first UTC in the first timezone
    property string currentCity: timezones[0].cities[0] // Default to the first city in the first timezone

    property string tempClockFormat: clockFormat
    property string tempTimezone: currentTimezone
    property string tempUtc: currentUtc
    property string tempCity: currentCity
    property int tempMethod: currentMethod

    property string lastFetchedTime: ""

    function loadSettings() {
        clockFormat = settingsWrapper.value("clockFormat", "12-hour").toString()
        currentTimezone = settingsWrapper.value("currentTimezone", timezones[0].text).toString()
        currentUtc = settingsWrapper.value("currentUtc", timezones[0].utc[0]).toString()
        currentCity = settingsWrapper.value("currentCity", timezones[0].cities[0]).toString()
        currentMethod = Number(settingsWrapper.value("currentMethod", 3))
        lastFetchedTime = settingsWrapper.value("lastFetchedTime", "").toString()

        tempClockFormat = clockFormat
        tempTimezone = currentTimezone
        tempUtc = currentUtc
        tempCity = currentCity
        tempMethod = currentMethod
    }

    function saveSettings() {
        settingsWrapper.setValue("clockFormat", tempClockFormat)
        settingsWrapper.setValue("currentTimezone", tempTimezone)
        settingsWrapper.setValue("currentUtc", tempUtc)
        settingsWrapper.setValue("currentCity", tempCity)
        settingsWrapper.setValue("currentMethod", tempMethod)
        settingsWrapper.setValue("lastFetchedTime", lastFetchedTime)

        clockFormat = tempClockFormat
        currentTimezone = tempTimezone
        currentUtc = tempUtc
        currentCity = tempCity
        currentMethod = tempMethod

        fetchWorldTime()
        fetchPrayerTimings()
    }

    function updateTime() {
        var now = new Date()
        var localTime = new Date(now.getTime() + (now.getTimezoneOffset() * 60000) + (utcOffset * 3600000))

        if (clockFormat === "12-hour") {
            currentTime = Qt.formatTime(localTime, "hh:mm:ss AP")
        } else {
            currentTime = Qt.formatTime(localTime, "HH:mm:ss")
        }
    }

    function formatTime(time) {
        var date = new Date("1970-01-01T" + time + "Z")
        if (clockFormat === "12-hour") {
            return Qt.formatTime(date, "hh:mm AP")
        } else {
            return Qt.formatTime(date, "HH:mm")
        }
    }

    function fetchPrayerTimings() {
        var now = new Date()
        var dateString = now.getDate().toString().padStart(2, '0') + "-" + (now.getMonth() + 1).toString().padStart(2, '0') + "-" + now.getFullYear()
        var timezoneData = timezones.find(tz => tz.text === currentTimezone)
        if (timezoneData) {
            var apiUrl = `http://api.aladhan.com/v1/timingsByCity/${dateString}?city=${currentCity}&country=${timezoneData.value.split(" ")[0]}&method=${currentMethod}&adjustment=1`

            var xhr = new XMLHttpRequest()
            xhr.open("GET", apiUrl, true)
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText)
                        var timings = response.data.timings
                        fajrTime = formatTime(timings.Fajr)
                        sunriseTime = formatTime(timings.Sunrise)
                        dhuhrTime = formatTime(timings.Dhuhr)
                        asrTime = formatTime(timings.Asr)
                        sunsetTime = formatTime(timings.Sunset)
                        maghribTime = formatTime(timings.Maghrib)
                        ishaTime = formatTime(timings.Isha)
                        imsakTime = formatTime(timings.Imsak)
                        midnightTime = formatTime(timings.Midnight)
                        firstthirdTime = formatTime(timings.Firstthird)
                        lastthirdTime = formatTime(timings.Lastthird)

                        lastFetchedTime = now.toISOString()
                        saveSettings()
                    } else {
                        console.error("Failed to fetch prayer timings")
                    }
                }
            }
            xhr.send()
        }
    }

    function fetchWorldTime() {
        var timezoneData = timezones.find(tz => tz.text === currentTimezone)
        if (timezoneData) {
            currentUtc = timezoneData.utc[0]
            var apiUrl = `http://worldtimeapi.org/api/timezone/${currentUtc}`

            var xhr = new XMLHttpRequest()
            xhr.open("GET", apiUrl, true)
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText)
                        var datetime = response.datetime
                        utcOffset = parseInt(response.utc_offset.slice(1, 3)) * (response.utc_offset.startsWith("-") ? -1 : 1)
                        updateTime()
                    } else {
                        console.error("Failed to fetch world time")
                    }
                }
            }
            xhr.send()
        }
    }

    Timer {
        id: timer
        interval: 1000 // Update every second
        running: true
        repeat: true
        onTriggered: {
            updateTime()
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainPage

        Component {
            id: mainPage
            Rectangle {
                color: "#2a2e32"

                Column {
                    anchors.centerIn: parent
                    spacing: 20

                    Text {
                        id: timeDisplay
                        text: currentTime
                        font.pointSize: 24
                        color: "white"
                    }

                    Text {
                        text: "Fajr: " + fajrTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Sunrise: " + sunriseTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Dhuhr: " + dhuhrTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Asr: " + asrTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Sunset: " + sunsetTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Maghrib: " + maghribTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Isha: " + ishaTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Imsak: " + imsakTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Midnight: " + midnightTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Firstthird: " + firstthirdTime
                        font.pointSize: 18
                        color: "white"
                    }

                    Text {
                        text: "Lastthird: " + lastthirdTime
                        font.pointSize: 18
                        color: "white"
                    }
                }

                Button {
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        margins: 20
                    }
                    text: qsTr("Settings")
                    onClicked: stackView.push(settingsPage)
                }

                Component.onCompleted: {
                    loadSettings()
                    fetchWorldTime()
                    fetchPrayerTimings()
                }
            }
        }

        Component {
            id: settingsPage
            Rectangle {
                color: "#2a2e32"

                Column {
                    anchors.centerIn: parent
                    spacing: 20

                    Text {
                        text: qsTr("Settings")
                        font.pointSize: 24
                        color: "white"
                    }

                    ComboBox {
                        id: settingsClockFormatSelector
                        model: [ "12-hour", "24-hour" ]
                        currentIndex: settingsClockFormatSelector.model.indexOf(tempClockFormat)
                        onCurrentTextChanged: {
                            tempClockFormat = settingsClockFormatSelector.currentText
                        }
                    }

                    ComboBox {
                        id: settingsTimezoneSelector
                        model: timezones.map(tz => tz.text)
                        currentIndex: timezones.map(tz => tz.text).indexOf(tempTimezone) // Set the current index based on the tempTimezone
                        onCurrentTextChanged: {
                            tempTimezone = settingsTimezoneSelector.currentText
                            var timezoneData = timezones.find(tz => tz.text === tempTimezone)
                            if (timezoneData) {
                                settingsCitySelector.model = timezoneData.cities
                                settingsCitySelector.currentIndex = timezoneData.cities.indexOf(tempCity) // Set the current index based on the tempCity
                                tempCity = timezoneData.cities[settingsCitySelector.currentIndex]
                                tempUtc = timezoneData.utc[0]
                            }
                        }
                    }

                    ComboBox {
                        id: settingsCitySelector
                        model: timezones.find(tz => tz.text === tempTimezone).cities
                        currentIndex: timezones.find(tz => tz.text === tempTimezone).cities.indexOf(tempCity) // Set the current index to the temp city
                        onCurrentTextChanged: {
                            tempCity = settingsCitySelector.currentText
                        }
                    }

                    ComboBox {
                        id: settingsMethodSelector
                        model: [
                            "University of Islamic Sciences, Karachi",
                            "Islamic Society of North America (ISNA)",
                            "Muslim World League"
                        ]
                        currentIndex: tempMethod - 1 // Map the tempMethod to the index
                        onCurrentIndexChanged: {
                            tempMethod = settingsMethodSelector.currentIndex + 1 // Map the index to the method value
                        }
                    }

                    Button {
                        text: qsTr("Save Changes")
                        onClicked: {
                            saveSettings()
                            stackView.pop()
                        }
                    }

                    Button {
                        text: qsTr("Back")
                        onClicked: {
                            stackView.pop()
                        }
                    }
                }
            }
        }
    }
}
