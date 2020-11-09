import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик поворота</b>"
//    property alias active: sensor.active


//    // ===== Датчик поворота =====
//    RotationSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: {
//            // текст виден, если ось Z определена
//            txtZ.visible = this.hasZ
//            // запустить опрос
//            this.active = true
//        }
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
            visible: sensor && sensor.hasZ
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtX.text = "Ускорение X:   " +
                (sensor && sensor.reading ? sensor.reading.x.toFixed(2) + " м/c²" : "Неизвестно")
        txtY.text = "Ускорение Y:   " +
                (sensor && sensor.reading ? sensor.reading.y.toFixed(2) + " м/c²" : "Неизвестно")
        if (sensor && sensor.hasZ) {
            txtZ.text = "Ускорение Z:   " +
                    (sensor && sensor.reading ? sensor.reading.z.toFixed(2) + " м/c²" : "Неизвестно")
        }
    }
}
