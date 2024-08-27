import QtQuick
import QtQuick.Controls

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Namaz")

    property string currentTimeZone: "UTC" // Default time zone
    property string currentTime: ""
    property string clockFormat: "12-hour" // Default clock format

    function updateTime() {
        var now = new Date();
        var utc = now.getTime() + (now.getTimezoneOffset() * 60000);
        var offset = 0;

        switch (currentTimeZone) {
            case "UTC":
                offset = 0;
                break;
            case "Europe/Moscow":
                offset = 3 * 60 * 60000; // UTC+3
                break;
            case "America/New_York":
                offset = -5 * 60 * 60000; // UTC-5
                break;
            case "Asia/Tokyo":
                offset = 9 * 60 * 60000; // UTC+9
                break;
        }

        var localTime = new Date(utc + offset);
        if (clockFormat === "12-hour") {
            currentTime = Qt.formatTime(localTime, "hh:mm:ss AP");
        } else {
            currentTime = Qt.formatTime(localTime, "HH:mm:ss");
        }
    }

    Timer {
        id: timer
        interval: 1000 // Обновление каждую секунду
        running: true
        repeat: true
        onTriggered: {
            updateTime();
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
                        id: settingsTimeZoneSelector
                        model: [ "UTC", "Europe/Moscow", "America/New_York", "Asia/Tokyo" ]
                        currentIndex: settingsTimeZoneSelector.model.indexOf(currentTimeZone)
                        onCurrentTextChanged: {
                            currentTimeZone = settingsTimeZoneSelector.currentText
                            updateTime();
                        }
                    }

                    ComboBox {
                        id: settingsClockFormatSelector
                        model: [ "12-hour", "24-hour" ]
                        currentIndex: settingsClockFormatSelector.model.indexOf(clockFormat)
                        onCurrentTextChanged: {
                            clockFormat = settingsClockFormatSelector.currentText
                            updateTime();
                        }
                    }

                    Button {
                        text: qsTr("Back")
                        onClicked: stackView.pop()
                    }
                }
            }
        }
    }
}
