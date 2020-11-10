import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtSensors 5.12
import QtQuick.Layouts 1.12

import MainControls 1.0
import CommonUtils 1.0
import Logic 1.0


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Android Sensors")


    SensorsAppModel {
        id: sensorsAppModel

        Component.onCompleted: {
            pnlMainPanel.init(sensorsAppModel)
            setSensorsActive(true)
        }
    }



    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: btnHeaderReturn
                text: qsTr("\u25C0")
                visible: stackView.depth > 1
                onClicked: {
                    var page = stackView.pop()
                    if (page)
                        page.destroy()
                }
            }
            Label {
                id: lblHeaderTitle
                text: stackView.currentItem.title
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                id: btnHeaderMenu
                text: qsTr("\u22EE")
                onClicked: menu.open()
            }
        }
    }


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: pnlMainPanel

        MainSensorPanel {
            id: pnlMainPanel
        }


        Connections {
            target: pnlMainPanel
            onSensorPanelClicked: stackView.displayDetailPage(sensorTypeName)
        }


        function displayDetailPage(sensorTypeName) {
            var page = SensorUtils.loadSensorDetailPage(sensorTypeName, this)
            if (page) {
                var sensor = sensorsAppModel.sensorByTypeName(sensorTypeName)
                page.setSensor(sensor)
                stackView.push(page)
            }
        }
    }


}
