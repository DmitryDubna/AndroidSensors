import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


//Frame {
//    id: control
//    //     title: qsTr("GroupBox")
//    property string title: "SensorPanel"
//    property string color: "white"

//    background: Item {
//        layer.enabled: true

//        opacity: 1

//        Rectangle {
//            id: rectBackgnd
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.bottom: parent.bottom
//            anchors.top: parent.top
//            anchors.topMargin: lblBackgnd.height / 2
//            anchors.bottomMargin: anchors.topMargin
//            border.color: "black"
//            radius: 10
//        }
//        Label {
//            id: lblBackgnd
//            text: control.title
////            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: control.top

//            background: Rectangle {
//                width: lblBackgnd.width
//                height: lblBackgnd.height
//                color: control.color === "transparent" ? "white" : control.color
//                border.color: "black"
//                radius: 10
//            }
//        }
//    }
//}


//GroupBox {
//      id: control
//      title: qsTr("GroupBox")

//      background: Rectangle {
////          y: control.topPadding - control.bottomPadding
////          width: parent.width
////          height: parent.height - control.topPadding + control.bottomPadding
//          color: "transparent"
//          border.color: "#21be2b"
//          radius: 2
//      }

//      label: Label {
//          x: control.leftPadding
//          width: control.availableWidth
//          text: control.title
//          color: "#21be2b"
//          elide: Text.ElideRight
//      }

//      Label {
//          text: qsTr("Content goes here!")
//      }
//  }


GroupBox {
    id: root

    property var sensor: undefined
    property string color: "transparent"

    signal clicked()


    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(readValues)
    }


    background: Rectangle {
        Rectangle {
            id: rectBackgnd
            anchors.fill: parent
            border.color: "black"
            radius: 10
            color: root.color
            visible: false
        }
        BrightnessContrast {
            anchors.fill: rectBackgnd
            source: rectBackgnd
            brightness: root.hovered ? 0 : 0.5
        }
        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }


    label: Text {
        id: txtTitle
        text: qsTr(root.title)
        anchors.left: root.left
        anchors.right: root.right
        anchors.leftMargin: root.leftPadding
    }
}
