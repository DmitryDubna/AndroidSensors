import QtQuick 2.12
import QtQuick.Controls 2.12
import QtSensors 5.12

SensorPanel {
//    title: "<b>Датчик наклона</b>"
//    property alias active: sensor.active

//    // ===== Датчик наклона =====
//    TiltSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }

    Column {
        spacing: 10

        Text {
            id: txtX
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: txtY
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtX.text = "Наклон X:      " +
                (sensor && sensor.reading ? sensor.reading.xRotation.toFixed(2) + "°" : "Неизвестно")
        txtY.text = "Наклон Y:      " +
                (sensor && sensor.reading ? sensor.reading.yRotation.toFixed(2) + "°" : "Неизвестно")
    }
}

