import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Магнетометр</b>"
//    property alias active: sensor.active


//    // ===== Магнетометр =====
//    Magnetometer {
//        id: sensor
//        skipDuplicates: true
//        returnGeoValues: true
//        active: false

//        onReadingChanged: {
//            readValues()
//        }
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
        Text {
            id: txtCalibrationLevel
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtX.text = "Магнитная индукция X:      " +
                (sensor && sensor.reading ? (sensor.reading.x * 1000000).toFixed(1) + " мкТл" : "Неизвестно")
        txtY.text = "Магнитная индукция Y:      " +
                (sensor && sensor.reading ? (sensor.reading.y * 1000000).toFixed(1) + " мкТл" : "Неизвестно")
        txtZ.text = "Магнитная индукция Z:      " +
                (sensor && sensor.reading ? (sensor.reading.z * 1000000).toFixed(1) + " мкТл" : "Неизвестно")
        txtCalibrationLevel.text = "Точность измерения:    " +
                (sensor && sensor.reading ? sensor.reading.calibrationLevel.toFixed(2) * 100 + "%" : "Неизвестно")
    }
}
