import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtSensors 5.12
import CommonUtils 1.0


Page {
    id: root

    property string backColor: "black"
    property string fontColor: "white"
    property var sensor: undefined


    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }


    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(updateValues)
        updateValues()
    }


    contentItem: ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: rectCompassView
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            CompassView {
                id: compassView
                anchors.horizontalCenter: rectCompassView.horizontalCenter
                anchors.verticalCenter: rectCompassView.verticalCenter
                azimuth: 90
            }

        }

        Label {
            id: txtTitle
            text: "Азимут:"
            font.pixelSize: 20
            font.bold: true
            Layout.alignment: Layout.Center
            color: fontColor
            elide: Text.ElideMiddle
        }
        Label {
            id: txtAzimuth
            font.pixelSize: 20
            font.bold: true
            Layout.alignment: Layout.Center
            bottomPadding: 20
            color: fontColor
            elide: Text.ElideMiddle
        }
    }


    function updateValues() {
        var {label, value} = root.getSensorInfo()
        txtAzimuth.text = label
//        compassView.azimuth = (value ? value : 0)
        compassView.setAzimuth(value)

    }


    function getSensorInfo() {
        let value = 0
        let label = "Неизвестно"

        if (sensor) {
            value = (sensor.reading ? sensor.reading.azimuth.toFixed(2) : undefined)
            label = (value !== undefined ? `${value}°` : "Неизвестно")

//            switch(displayType)
//            {
//            case LightSensorDetailPage.DisplayType.Lux:
//                value = (sensor.reading ? sensor.reading.illuminance : undefined)
//                label = (value !== undefined ? `${value} лк` : "Неизвестно")
//                bright = (value !== undefined ? brightnessFromLux(value) : 0)
//                break

//            case LightSensorDetailPage.DisplayType.LightLevel:
//                value = (sensor.reading ? sensor.reading.lightLevel : undefined)
//                label = (value ? SensorUtils.getAmbientLightDesc(value) : "Неизвестно")
//                bright = (value ? brightnessFromLightLevel(value) : 0)
//                break

//            default:
//                break
//            }
        }
        return {label, value}
    }
}
