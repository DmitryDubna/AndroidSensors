import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtSensors 5.12

GroupBox {
    id: root
    antialiasing: true
    title: "<b>Доступные датчики</b>"
    property string listColor: "transparent"

    property var availableSensors: []

    background: Rectangle {
        id: rectBackgnd
        y: root.topPadding - root.bottomPadding
        width: root.width
        height: parent.height - root.topPadding + root.bottomPadding
        color: root.listColor
        border.color: "black"
        radius: 10
    }

    label: Text {
        id: txtTitle
        text: qsTr(root.title)
//        font.pixelSize: 12
    }


    // модель
    ListModel {
        id: modelSensorList

//        ListElement {
//            name: "Bill Smith"
//            number: "555 3264"
//        }
//        ListElement {
//            name: "John Brown"
//            number: "555 8426"
//        }
//        ListElement {
//            name: "Sam Wise"
//            number: "555 0473"
//        }
    }

    // делегат
    Component {
        id: delegateItem
        Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 4
            height: txtItemInfo.height

            Text {
                id: txtItemInfo
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                text: `${index + 1}. ${name}`
            }
        }
    }

    // подсветка
    Component {
        id: highlight
        Rectangle {
            width: 180
            height: 40
            color: listColor
            radius: 5
            //            y: view.currentItem.y
            //            Behavior on y {
            //                SpringAnimation {
            //                    spring: 3
            //                    damping: 0.2
            //                }
            //            }
        }
    }

    // компонент
    ListView {
        id: view
        clip: true
        anchors.fill: parent
        model: modelSensorList
        delegate: delegateItem
        spacing: 10
        //        highlight: highlight
        //        highlightFollowsCurrentItem: false
        focus: true
    }


    function setSensorNames(sensorNames) {
        clearSensorNames()
        sensorNames.forEach(name => appendSensorName(name))
    }


    function appendSensorName(sensorName) {
        modelSensorList.append({name: sensorName})
    }


    function clearSensorNames() {
        modelSensorList.clear()
    }
}

