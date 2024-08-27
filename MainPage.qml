// MainPage.qml
import QtQuick
import QtQuick.Controls

Page {
    title: qsTr("Clock")

    Rectangle {
        anchors.fill: parent
        color: (Qt.theme === "dark") ? "#2a2e32" : "#eff0f1"

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                id: timeDisplay
                text: clockManager.currentTime
                font.pointSize: 24
                color: (Qt.theme === "dark") ? "white" : "black"
            }

            Button {
                text: qsTr("Settings")
                onClicked: {
                    stackView.push(SettingsPage {
                        timeZones: timeZones
                        onTimeZoneChanged: {
                            clockManager.setTimeZone(newTimeZone);
                        }
                    });
                }
            }
        }

        Timer {
            id: timer
            interval: 1000 // Update every second
            running: true
            repeat: true
            onTriggered: {
                timeDisplay.text = clockManager.currentTime; // Update the time display
            }
        }
    }
}
