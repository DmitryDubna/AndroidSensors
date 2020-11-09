import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик касаний</b>"
//    property alias active: sensor.active


//    // ===== Датчик касаний =====
//    TapSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

//        Text {
//            id: txtX
//            verticalAlignment: Text.AlignVCenter
//        }
//        Text {
//            id: txtY
//            verticalAlignment: Text.AlignVCenter
//        }
//        Text {
//            id: txtZ
//            verticalAlignment: Text.AlignVCenter
//        }

        Component.onCompleted: readValues()
    }


    function readValues() {
//        txtX.text = "Ускорение X:   " + (sensor.reading ? sensor.reading.x.toFixed(2) + " м/c²" : "Неизвестно")
//        txtY.text = "Ускорение Y:   " + (sensor.reading ? sensor.reading.y.toFixed(2) + " м/c²" : "Неизвестно")
//        txtZ.text = "Ускорение Z:   " + (sensor.reading ? sensor.reading.z.toFixed(2) + " м/c²" : "Неизвестно")
    }
}
