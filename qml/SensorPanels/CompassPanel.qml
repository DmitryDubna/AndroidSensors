import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Компас</b>"
//    property alias active: sensor.active

//    // ===== Компас =====
//    Compass {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }

    Column {
        spacing: 10
        Text {
            id: txtAngle
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            id: txtCalibrationLevel
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtAngle.text = "Азимут:        " +
                (sensor && sensor.reading ? sensor.reading.azimuth.toFixed(2) + "°" : "Неизвестно")
        txtCalibrationLevel.text = "Точность измерения:    " +
                (sensor && sensor.reading ? sensor.reading.calibrationLevel.toFixed(2) * 100 + "%" : "Неизвестно")
    }
}



