import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик давления</b>"
//    property alias active: sensor.active


//    // ===== Датчик давления =====
//    PressureSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtPressure
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: txtTemperature
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtPressure.text = "Атмосферное давление:  " +
                (sensor && sensor.reading ? sensor.reading.pressure.toFixed(2) + " Па" : "Неизвестно")
        txtTemperature.text = "Температура:           " +
                (sensor && sensor.reading ? sensor.reading.temperature.toFixed(2) + " м/c²" : "Неизвестно")
    }
}
