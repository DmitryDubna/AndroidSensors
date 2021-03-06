import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Альтиметр</b>"
//    property alias active: sensor.active


//    // ===== Альтиметр =====
//    Altimeter {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtAltitude
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtAltitude.text = "Высота над уровнем моря:   " +
                (sensor && sensor.reading ? sensor.reading.altitude.toFixed(2) + " м" : "Неизвестно")
    }
}
