import QtQuick 2.13
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

        }
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
            const delta = 15
            if ((lastValue > -delta) && (lastValue < delta)) {
                data = data.map(v => (v > 270 ? (v - 360) % 360 : v))
            }
            data = data.filter(v => Math.abs(v - lastValue) < delta)
            const sum = data.reduce((prev, cur) => prev + cur)
            // среднее значение
            avgValue = Math.round(sum / data.length)
        }
        // отобразить значение
        compassView.azimuth = avgValue
//        compassView.azimuth = ((compassView.azimuth - 50) + 360) % 360
    }
}
