import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик внешней температуры</b>"
//    property alias active: sensor.active


//    // ===== Датчик внешней температуры =====
//    AmbientTemperatureSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtTemperature
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtTemperature.text = "Температура:     " +
                (sensor && sensor.reading ? sensor.reading.temperature.toFixed(1) + "°C" : "Неизвестно")
    }
}
