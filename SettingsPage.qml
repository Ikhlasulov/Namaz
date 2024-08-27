// SettingsPage.qml
import QtQuick
import QtQuick.Controls

Page {
    title: qsTr("Settings")

    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: qsTr("Select Time Zone:")
            font.pointSize: 24
        }

        ComboBox {
            id: timeZoneSelector
            model: timeZones // This will be set from the main page
            onCurrentTextChanged: {
                // Emit a signal to notify the main page of the change
                timeZoneChanged(timeZoneSelector.currentText);
            }
        }
    }

    signal timeZoneChanged(string newTimeZone)
}
