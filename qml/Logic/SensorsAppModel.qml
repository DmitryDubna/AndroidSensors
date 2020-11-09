import QtQuick 2.0
import CommonUtils 1.0


QtObject {
    property var sensors: new Map()

    Component.onCompleted: {
        initSensorList()
//        sensors.forEach(s => console.log(s.typeName, s.displayName))
    }


    function initSensorList() {
        var {types, titles} = SensorUtils.getAvailableSensorTypes()
        types.forEach(typeName => {
                          var sensor = SensorUtils.createSensor(typeName, this)
                          sensors.set(typeName, sensor)
                      })
    }


    function sensorByTypeName(typeName) {
        return sensors.get(typeName)
    }

    function setSensorsActive(active) {
        [...sensors.values()].forEach(s => s.active = active)
    }

}
