import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12


SensorPanel {
//    title: "<b>Датчик света</b>"
//    property alias active: sensor.active
//    property LightSensor sensor: sensor

//    onVisibleChanged: {
//        if (sensor)
//            sensor.active = visible
//    }

//    // ===== Датчик света =====
//    LightSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtFov
            verticalAlignment: Text.AlignVCenter
            text: `Поле зрения:         ${sensor.fieldOfView}°`
            visible: sensor && sensor.fieldOfView > 0
            wrapMode: Text.Wrap
        }
        Text {
            id: txtLightLevel
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtLightLevel.text = "Интенсивность света:      " +
                (sensor && sensor.reading ? sensor.reading.illuminance + " лк" : "Неизвестно")
    }
}
