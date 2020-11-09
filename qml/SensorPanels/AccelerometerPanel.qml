import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Акселерометр</b>"
//    property alias active: sensor.active


//    // ===== Акселерометр =====
//    Accelerometer {
//        id: sensor
//        skipDuplicates: true
//        active: false
//        accelerationMode: Accelerometer.User

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
        Text {
            id: txtZ
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtX.text = "Ускорение X:   " +
                (sensor && sensor.reading ? sensor.reading.x.toFixed(2) + " м/c²" : "Неизвестно")
        txtY.text = "Ускорение Y:   " +
                (sensor && sensor.reading ? sensor.reading.y.toFixed(2) + " м/c²" : "Неизвестно")
        txtZ.text = "Ускорение Z:   " +
                (sensor && sensor.reading ? sensor.reading.z.toFixed(2) + " м/c²" : "Неизвестно")
    }
}
