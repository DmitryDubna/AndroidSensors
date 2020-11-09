import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Гироскоп</b>"
//    property alias active: sensor.active


//    // ===== Гироскоп =====
//    Gyroscope {
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
        Text {
            id: txtZ
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtX.text = "Угловая скорость X:    " +
                (sensor && sensor.reading ? sensor.reading.x.toFixed(2) + "°/c" : "Неизвестно")
        txtY.text = "Угловая скорость Y:    " +
                (sensor && sensor.reading ? sensor.reading.y.toFixed(2) + "°/c" : "Неизвестно")
        txtZ.text = "Угловая скорость Z:    " +
                (sensor && sensor.reading ? sensor.reading.z.toFixed(2) + "°/c" : "Неизвестно")
    }
}
