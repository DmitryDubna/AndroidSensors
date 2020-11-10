import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtSensors 5.12
import CommonUtils 1.0


Page {
    id: root

    enum DisplayType {
        Unknown,
        Lux,
        LightLevel
    }

    property string backColor: "black"
    property string fontColor: "white"
    property var sensor: undefined
    property var displayType: LightSensorDetailPage.DisplayType.Unknowm



    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }


    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(updateValues)

        if (sensor instanceof LightSensor) {
            displayType = LightSensorDetailPage.DisplayType.Lux
            txtTitle.text = "Интенсивность света:"
        } else if (sensor instanceof AmbientLightSensor) {
            displayType = LightSensorDetailPage.DisplayType.LightLevel
            txtTitle.text = "Освещенность:"
        } else {
            displayType = LightSensorDetailPage.DisplayType.Unknown
            txtTitle.text = ""
        }

        updateValues()
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

        Label {
            id: txtTitle
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            color: fontColor
            elide: Text.ElideMiddle
        }
        Label {
            id: txtLightValue
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 20
            color: fontColor
            elide: Text.ElideMiddle
        }

//        Rectangle {
//            id: rectText
//            color: "transparent"
//            Layout.alignment: Qt.AlignCenter
//            Layout.fillWidth: true
//            height: fontMetrics.height * 8
////            height: contentHeight

//            FontMetrics {
//                id: fontMetrics
//            }

//            Text {
//                id: txtTitle
//                font.pixelSize: 20
//                font.bold: true
//                anchors.centerIn: parent
//                anchors.top: parent.top
//                color: fontColor
//                elide: Text.ElideMiddle
//            }

//            Text {
//                id: txtLightValue
//                text: "Неизвестно"
//                font.pixelSize: 20
//                font.bold: true
//                anchors.centerIn: parent
//                anchors.top: txtTitle.bottom
//                color: fontColor
//                elide: Text.ElideMiddle
//            }
//        }
    }


    function updateValues() {
        var {label, bright} = getSensorInfo()
        txtLightValue.text = label
        bcLamp.brightness = bright

    }


    function getSensorInfo() {
        let value = 0
        let bright = 0
        let label = "Неизвестно"

        if (sensor) {
            switch(displayType)
            {
            case LightSensorDetailPage.DisplayType.Lux:
                value = (sensor.reading ? sensor.reading.illuminance : undefined)
                label = (value !== undefined ? `${value} лк` : "Неизвестно")
                bright = (value !== undefined ? brightnessFromLux(value) : 0)
                break

            case LightSensorDetailPage.DisplayType.LightLevel:
                value = (sensor.reading ? sensor.reading.lightLevel : undefined)
                label = (value ? SensorUtils.getAmbientLightDesc(value) : "Неизвестно")
                bright = (value ? brightnessFromLightLevel(value) : 0)
                break

            default:
                break
            }
        }
        return {label, bright}
    }


    function brightnessFromLux(lux) {
        var min = -0.7
        var max = 0.5
        lux = (lux > 1000 ? 1000 : lux)
        return (min + (max - min) / 1000 * lux)
    }


    function brightnessFromLightLevel(lightLevel)
    {
        switch(lightLevel)
        {
        case AmbientLightReading.Dark:
            return -0.7
        case AmbientLightReading.Twilight:
            return -0.4
        case AmbientLightReading.Light:
            return 0
        case AmbientLightReading.Bright:
            return 0.3
        case AmbientLightReading.Sunny:
            return 0.5
        default:
            break;
        }
    }
}

