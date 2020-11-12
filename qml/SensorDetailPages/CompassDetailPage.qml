import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtSensors 5.12
import CommonUtils 1.0


Page {
    id: root

    property string backColor: "black"
    property string fontColor: "white"
    property var sensor: undefined
    property int pollInterval: 300
    property var sensorData: []


    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }

    Timer {
        id: timer
        interval: pollInterval
        running: false
        repeat: true
        onTriggered: displayValues()
    }


    contentItem: ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: rectCompassView
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true


            CompassView {
                id: compassView
                anchors.fill: parent
                azimuth: 0
            }


            SequentialAnimation {
                id: rotationAnimation
                running: false
                loops: 1

//                PauseAnimation {
//                    duration: 1000
//                }

                NumberAnimation {
                    id: azimuthAnimation
                    target: compassView
                    property: "azimuth"
                    easing.type: Easing.InOutSine
                    duration: pollInterval
                }
            }

        }

//        Label {
//            id: txtTitle
//            text: "Азимут:"
//            font.pixelSize: 20
//            font.bold: true
//            Layout.alignment: Layout.Center
//            color: fontColor
//            elide: Text.ElideMiddle
//        }
//        Label {
//            id: txtAzimuth
//            font.pixelSize: 20
//            font.bold: true
//            Layout.alignment: Layout.Center
//            bottomPadding: 20
//            color: fontColor
//            elide: Text.ElideMiddle
//        }
    }


//    function readValues() {
//        var {label, value} = root.getSensorData()
//        txtAzimuth.text = label
//        compassView.setAzimuth(value)
//    }


//    function getSensorData() {
//        let value = 0
//        let label = "Неизвестно"

//        if (sensor) {
//            value = (sensor.reading ? sensor.reading.azimuth.toFixed(2) : undefined)
//            label = (value !== undefined ? `${value}°` : "Неизвестно")
//        }
//        return {label, value}
//    }


    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(readValues)
        timer.start()
    }


    function readValues() {
        if (!root)
            return
        var value = root.getSensorData()
        if (value)
            sensorData.push(value)
    }


    function getSensorData() {
        if (sensor && sensor.reading) {
            return (sensor.reading.azimuth + 360) % 360
        }
        return undefined
    }


    function displayValues() {
        let avgValue = 0
        // если данные не пусты
        if (sensorData.length > 0)
        {
            // скопировать массив
            let data = [...sensorData]
            // очистить массив данных
            sensorData.splice(0, sensorData.length)
            // сумма значений
            const lastValue = data[data.length - 1]

//            console.log("До:", [...data])

            const delta = 15

            if ((lastValue > -delta) && (lastValue < delta))
                data = data.map(v => (v > 270 ? (v - 360) % 360 : v))

            data = data.filter(v => Math.abs(v - lastValue) < delta)

//            console.log("После:", [...data])

            const sum = data.reduce((prev, cur) => prev + cur)
            // среднее значение
            avgValue = Math.round(sum / data.length)

//            console.log("Среднее:", avgValue)
        }
        // отобразить значение
//        compassView.setAzimuth(avgValue)

//        rotationAnimation.angleTo = compassView.azimuth + 20

//        rotationAnimation.angleTo = (avgValue + 360) % 360

        rotationAnimation.stop()
//        updateAzimuth(azimuthAnimation.to - 50)
        updateAzimuth(avgValue)
        rotationAnimation.start()
    }


    function updateAzimuth(value) {
        let from = (azimuthAnimation.to + 360) % 360
        let to = (value + 360) % 360

        console.log(`from: ${from};   to: ${to}`)

        const delta = to - from
        if (Math.abs(delta) > 180) {
            const sign =(delta > 0 ? 1 : -1)
            const diff = delta - 360 * sign
            to = from + diff /** sign*/
        }

        azimuthAnimation.from = from
        azimuthAnimation.to = to
    }

}
