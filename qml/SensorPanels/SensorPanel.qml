import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


GroupBox {
    id: root

    anchors.margins: 10

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
            id: bcEffect
            anchors.fill: rectBackgnd
            source: rectBackgnd
//            brightness: root.hovered ? 0 : 0.5
            brightness: 0.5
        }
        MouseArea {
            id: maBackground
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


    states: [
        State {
            name: "pressed"
            when: maBackground.containsPress

            PropertyChanges {
                target: bcEffect
                brightness: 0
            }
            PropertyChanges {
                target: txtTitle
                font.pixelSize: 16
            }
            PropertyChanges {
                target: root
                anchors.margins: 6
            }
        }
    ]

    transitions: [
        Transition {
            to: "*"
            NumberAnimation {
                target: bcEffect
                property: "brightness"
                duration: 500
            }
            NumberAnimation {
                target: txtTitle
                property: "font.pixelSize"
                duration: 500
            }
            NumberAnimation {
                target: root
                property: "anchors.margins"
            }
        }
    ]
}
