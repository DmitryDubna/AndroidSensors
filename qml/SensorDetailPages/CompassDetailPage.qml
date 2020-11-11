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

    property var sensorData: []


    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }

    Timer {
        id: timer
        interval: 500
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
                azimuth: 90
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
//        readValues()
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
//            return sensor.reading.azimuth
            return (sensor.reading.azimuth + 360) % 360
        }
        return undefined
    }


    function displayValues() {
        let avgValue = 0
//        let label = "Неизвестно"
        // если данные не пусты
        if (sensorData.length > 0)
        {
            // скопировать массив
            let data = [...sensorData]
            // очистить массив данных
            sensorData.splice(0, sensorData.length)
            // сумма значений
//            const sum = data.reduce((prev, cur) => prev + cur)
            const lastValue = data[data.length - 1]

            console.log("До:", [...data])

            const delta = 20

            if ((lastValue > -delta) && (lastValue < delta))
                data = data.map(v => (v > 270 ? (v - 360) % 360 : v))

            data = data.filter(v => Math.abs(v - lastValue) < delta)

            console.log("После:", [...data])

            const sum = data.reduce((prev, cur) => prev + cur)
            // среднее значение
            avgValue = Math.round(sum / data.length)
//            // лейбл
//            label = `${avgValue}°`

            console.log("Среднее:", avgValue)
        }
        // отобразить значение
//        txtAzimuth.text = label
        compassView.setAzimuth(avgValue)
    }



}
