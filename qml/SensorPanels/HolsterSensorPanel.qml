import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик нахождения в кармане</b>"
//    property alias active: sensor.active


//    // ===== Датчик нахождения в кармане =====
//    HolsterSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtHolstered
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtHolstered.text = "Устройство в кармане:      " +
                (sensor && sensor.reading ? (sensor.reading.holstered ? "Да" : "Нет") : "Неизвестно")
    }
}
