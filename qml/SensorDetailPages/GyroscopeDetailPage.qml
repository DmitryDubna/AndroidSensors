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
    property int pollInterval: 1000
    property var sensorData: []


    background: Rectangle {
        anchors.fill: parent
        color: backColor
    }

//    Timer {
//        id: timer
//        interval: pollInterval
//        running: false
//        repeat: true
//        onTriggered: displayValues()
//    }


    contentItem: ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: rectView
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                id: rect
                width: 150; height: 100; anchors.centerIn: parent
                color: "red"
                antialiasing: true

//                property int angle: 0

//                Behavior on angle {
//                    ParallelAnimation {
//                        RotationAnimation {
//                            target: textAngle
//                            property: "rotation"
//                            to: -rect.angle
//                            duration: 1000
//                            direction: RotationAnimation.Shortest
//                        }
//                        RotationAnimation {
//                            target: rect
//                            property: "rotation"
//                            to: rect.angle
//                            duration: 1000
//                            direction: RotationAnimation.Shortest
//                        }
//                    }
//                }


                Text {
                    id: textAngle
                    anchors.centerIn: rect
                    text: ((rect.rotation + 360) % 360).toFixed(1)
                    rotation: -rect.rotation

                    Behavior on rotation {
                        RotationAnimation { duration: 1000; direction: RotationAnimation.Shortest }
                    }
                }

                //                states: [
                //                    State {
                //                        name: "rotated-90"
                //                        PropertyChanges { target: rect; rotation: 90 }
                //                    },
                //                    State {
                //                        name: "rotated-180"
                //                        PropertyChanges { target: rect; rotation: 180 }
                //                    }
                //                ]

                //                transitions: Transition {
                //                    RotationAnimation { duration: 1000 }
                //                }
                //            }

                //            MouseArea {
                //                anchors.fill: parent;
                //                onClicked: rect.state = (rect.state === "rotated-90" ? "rotated-180" : "rotated-90")
                //            }

                MouseArea {
                    anchors.fill: parent
                    onClicked: rect.rotation = (rect.rotation + 30 + 360) % 360
//                    onClicked: rect.angle += 30
                }

                Behavior on rotation {
                    RotationAnimation { duration: 1000; direction: RotationAnimation.Shortest }
                }
            }
        }
    }


    function setSensor(sensor) {
        this.sensor = sensor
        sensor.readingChanged.connect(readValues)
//        timer.start()
    }


    function readValues() {
//        if (!root)
//            return
//        var value = root.getSensorData()
//        if (value)
//            sensorData.push(value)
    }

}
