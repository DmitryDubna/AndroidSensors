import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12
import QtGraphicalEffects 1.12
import CommonUtils 1.0


SensorPanel {
    id: root
//    title: "<b>Датчик внешнего освещения</b>"
//    property alias active: sensor.active

//    // карта соответствия [значение: описание]
//    property var ambientLightDesc: new Map([
//       [AmbientLightReading.Undefined, "Неизвестно"],
//       [AmbientLightReading.Dark, "Темно"],
//       [AmbientLightReading.Twilight, "Сумерки"],
//       [AmbientLightReading.Light, "Искусственный свет"],
//       [AmbientLightReading.Bright, "Светло"],
//       [AmbientLightReading.Sunny, "Солнечно"]
//   ])


//    // ===== Датчик внешнего освещения =====
//    AmbientLightSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }

    Column {
        spacing: 10

        //        Text {
        //            id: txtLight
        //            verticalAlignment: Text.AlignVCenter
        //        }

        Text {
            id: txtLight
            verticalAlignment: Text.AlignVCenter
        }
        Rectangle {
            color: "transparent"
            width: 100; height: 150

            Image {
                id: imgLamp
                anchors.fill: parent
                source: ResourceUtils.smallLampIconPath
                fillMode: Image.PreserveAspectFit
                visible: false
            }
            BrightnessContrast {
                id: bcLamp
                anchors.fill: imgLamp
                source: imgLamp
                //                        brightness: root.hovered ? 0.4 : 0.7
            }
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtLight.text = "Значение:      " +
                (sensor && sensor.reading ? SensorUtils.getAmbientLightDesc(sensor.reading.lightLevel): "Неизвестно")
        if (sensor && sensor.reading)
            updateLampView(sensor.reading.lightLevel)
    }


    function updateLampView(lightLevel)
    {
        switch(lightLevel)
        {
        case AmbientLightReading.Dark:
            bcLamp.brightness = -0.7
            break;
        case AmbientLightReading.Twilight:
            bcLamp.brightness = -0.2
            break;
        case AmbientLightReading.Light:
            bcLamp.brightness = 0
            break;
        case AmbientLightReading.Bright:
            bcLamp.brightness = 0.3
            break;
        case AmbientLightReading.Sunny:
            bcLamp.brightness = 0.5
            break;
        default:
            break;
        }
    }
}
