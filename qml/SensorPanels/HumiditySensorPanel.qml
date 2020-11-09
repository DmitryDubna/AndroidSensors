import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик влажности</b>"
//    property alias active: sensor.active


//    // ===== Датчик влажности =====
//    HumiditySensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtAbsoluteHumidity
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: txtRelativeHumidity
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtAbsoluteHumidity.text = "Абсолютная влажность:       " +
                (sensor && sensor.reading ? sensor.reading.absoluteHumidity.toFixed(2) + " г/м³" : "Неизвестно")
        txtRelativeHumidity.text = "Относительная влажность:    " +
                (sensor && sensor.reading ? sensor.reading.relativeHumidity.toFixed(2) + "%" : "Неизвестно")
    }
}
