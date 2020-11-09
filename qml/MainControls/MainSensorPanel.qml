import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtSensors 5.12
import QtQuick.Layouts 1.12

import CommonUtils 1.0


Page {
    id: root
    title: "Общие сведения"

    property var marginValue: 0
    property var model: null

    signal sensorPanelClicked(string sensorTypeName)

//    Component.onCompleted: init()

//    function init() {

//        // получить список типов датчиков
//        var {types: sensorTypes, titles: sensorTitles} = SensorUtils.getAvailableSensorTypes()
//        // отобразить список имен датчиков
//        sensorListView.setSensorNames(sensorTitles)
//        // сформировать панели для всех доступных датчиков
//        initSensorPanels(sensorTypes)
//        // запустить опрос всех датчиков
//        Array.from(containerSensorPanels.children).forEach(panel => panel.active = true)
//    }

//    function initSensorPanels(sensorTypes) {
//        sensorTypes.forEach(type => initSensorPanel(type))
//    }


//    function initSensorPanel(sensorName) {
//        // создать экземпляр ...
//        var panel = SensorUtils.loadSensorPanel(sensorName, containerSensorPanels)
//        // ... и настроить его
//        panel.anchors.left = containerSensorPanels.left
//        panel.anchors.right = containerSensorPanels.right
//        panel.anchors.margins = marginValue
//        panel.color = "lightgreen"
//        panel.clicked.connect(() => sensorPanelClicked(sensorName))
//    }


    function init(model) {
        this.model = model
        // отобразить список имен датчиков
        fillSensorsList(model)
        // сформировать панели для всех доступных датчиков
        initSensorPanels(model.sensors)
        // запустить опрос всех датчиков
//        Array.from(containerSensorPanels.children).forEach(panel => panel.active = true)
    }


    function fillSensorsList(model) {
        // получить список отображаемых имен датчиков
        var displayNames = [...model.sensors.values()].map(s => s.displayName)
        // отобразить список имен датчиков
        sensorListView.setSensorNames(displayNames)
    }


    function initSensorPanels(sensors) {
        sensors.forEach(s => initSensorPanel(s))
    }


    function initSensorPanel(sensor) {
        // создать панель ...
        var panel = SensorUtils.loadSensorPanel(sensor.typeName, containerSensorPanels)
        // ... и настроить ее
        panel.anchors.left = containerSensorPanels.left
        panel.anchors.right = containerSensorPanels.right
        panel.anchors.margins = marginValue
        panel.color = "lightgreen"
        panel.title = `<b>${sensor.displayName}</b>`
        // установить датчик
        panel.setSensor(sensor)
        // обработчики
        panel.clicked.connect(() => sensorPanelClicked(sensor.typeName))
    }

    // ==========================================================================

    Column {
        id: columnTop
        anchors.fill: parent
        spacing: 10
        clip: true

        // ===== Список датчиков =====
        SensorListView {
            id: sensorListView
            width: parent.width
            height: 200
            listColor: "#ddd"
        }

        // ===== Панели датчиков =====
        Flickable {
            clip: true
            width: parent.width
            height: parent.height - y

            contentWidth: width
            contentHeight: containerSensorPanels.height

            ScrollBar.vertical: ScrollBar {
                id: flickScroll
            }

            Column {
                id: containerSensorPanels
                width: columnTop.width
                spacing: 4
            }
        }
    }
}
