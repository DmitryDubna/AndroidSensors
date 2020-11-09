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

    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }


//    // ===== Датчик света =====
//    LightSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


//    contentItem: ColumnLayout {
//        anchors.fill: parent

//        Rectangle {
//            color: "transparent"
//            Layout.fillWidth: true
//            Layout.fillHeight: true

//            Image {
//                id: imgLamp
//                anchors.centerIn: parent
//                source: ResourceUtils.bigLampIconPath
//                fillMode: Image.PreserveAspectFit
//                visible: false
//            }
//            BrightnessContrast {
//                id: bcLamp
//                anchors.fill: imgLamp
//                source: imgLamp
//            }
//        }
//        Rectangle {
//            id: rectText
//            color: "transparent"
//            Layout.alignment: Qt.AlignCenter
//            Layout.fillWidth: true
//            height: fontMetrics.height * 4

//            FontMetrics {
//                id: fontMetrics
//            }

//            Text {
//                id: txtLightValue
//                text: "Неизвестно"
//                font.pixelSize: 20
//                font.bold: true
//                anchors.centerIn: parent
//                color: fontColor
//            }
//        }
//    }



//    // ===== Датчик света =====
//    LightSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }

    property var sensor: undefined

    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(readValues)
//        sensor.active = true
    }


    contentItem: ColumnLayout {
        anchors.fill: parent

        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: imgLamp
                anchors.centerIn: parent
                source: ResourceUtils.bigLampIconPath
                fillMode: Image.PreserveAspectFit
                visible: false
            }
            BrightnessContrast {
                id: bcLamp
                anchors.fill: imgLamp
                source: imgLamp
            }
        }
        Rectangle {
            id: rectText
            color: "transparent"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            height: fontMetrics.height * 4

            FontMetrics {
                id: fontMetrics
            }

            Text {
                id: txtLightValue
                text: "Неизвестно"
                font.pixelSize: 20
                font.bold: true
                anchors.centerIn: parent
                color: fontColor
            }
        }
    }





    function readValues() {
        txtLightValue.text = "Интенсивность света:      " +
                        (sensor.reading ? sensor.reading.illuminance + " лк" : "Неизвестно")
        if (sensor.reading) {
            bcLamp.brightness = brightnessFromLux(sensor.reading.illuminance)
//            console.log(`яркость = ${bcLamp.brightness}`)
        }
    }


    function brightnessFromLux(lux) {
        var min = -0.7
        var max = 0.5
        lux = (lux > 1000 ? 1000 : lux)
        return (min + (max - min) / 1000 * lux)
    }
}

