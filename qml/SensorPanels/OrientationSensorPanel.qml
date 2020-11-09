import QtQuick 2.0
import QtQuick.Controls 2.12
import QtSensors 5.12
import CommonUtils 1.0


SensorPanel {
//    title: "<b>Датчик ориентации</b>"
//    property alias active: sensor.active

//    // карта соответствия [значение: описание]
//    property var orientDesc: new Map([
//       [OrientationReading.Undefined, "Неизвестно"],
//       [OrientationReading.TopUp, "Нормальное положение"],
//       [OrientationReading.TopDown, "Перевернутое положение"],
//       [OrientationReading.LeftUp, "Левым боком вверх"],
//       [OrientationReading.RightUp, "Правым боком вверх"],
//       [OrientationReading.FaceUp, "Экраном вверх"],
//       [OrientationReading.FaceDown, "Экраном вниз"]
//   ])


//    // ===== Датчик ориентации =====
//    OrientationSensor {
//        id: sensor
//        skipDuplicates: true
//        active: false

//        onReadingChanged: readValues()
//        Component.onCompleted: this.active = true
//    }


    Column {
        spacing: 10

        Text {
            id: txtOrientation
            verticalAlignment: Text.AlignVCenter
        }

        Component.onCompleted: readValues()
    }


    function readValues() {
        txtOrientation.text = "Ориентация:   " +
                (sensor && sensor.reading ? SensorUtils.getOrientDesc(sensor.reading.orientation) : "Неизвестно")
    }
}
