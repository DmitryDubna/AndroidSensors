import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик режима <Ноутбук / планшет></b>"
//    property alias active: sensor.active


//    // ===== Датчик режима <Ноутбук / планшет> =====
//    LidSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtTabletMode
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: txtLaptopMode
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtTabletMode.text = "Режим планшета:       " +
                (sensor && sensor.reading ? (sensor.reading.backLidClosed ? "Да" : "Нет") : "Неизвестно")
        txtLaptopMode.text = "Режим ноутбука:       " +
                (sensor && sensor.reading ? (sensor.reading.frontLidClosed ? "Да" : "Нет") : "Неизвестно")
    }
}
