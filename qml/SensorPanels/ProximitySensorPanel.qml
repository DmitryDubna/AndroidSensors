import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик приближения</b>"
//    property alias active: sensor.active


//    // ===== Датчик приближения =====
//    ProximitySensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtNear
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtNear.text = "Объект расположен:      " +
                (sensor && sensor.reading ? (sensor.reading.near ? "Близко" : "Далеко") : "Неизвестно")
    }
}
