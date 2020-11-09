import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик расстояния</b>"
//    property alias active: sensor.active


//    // ===== Датчик расстояния =====
//    DistanceSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtDistance
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtDistance.text = "Расстояние до объекта:       " +
                (sensor && sensor.reading ? sensor.reading.distance.toFixed(1) + " см" : "Неизвестно")
    }
}
