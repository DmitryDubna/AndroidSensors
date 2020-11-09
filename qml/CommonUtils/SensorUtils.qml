pragma Singleton
import QtQuick 2.0
import QtSensors 5.12


QtObject {
    // карта имен датчиков
    property var mapSensorTitles: new Map([
        ["QAccelerometer",              "Акселерометр"],
        ["QAltimeter",                  "Альтиметр"],
        ["QAmbientLightSensor",         "Датчик внешнего освещения"],
        ["QAmbientTemperatureSensor",   "Датчик внешней температуры"],
        ["QCompass",                    "Компас"],
        ["QDistanceSensor",             "Датчик расстояния"],
        ["QGyroscope",                  "Гироскоп"],
        ["QHolsterSensor",              "Датчик нахождения в кармане"],
        ["QHumiditySensor",             "Датчик влажности"],
        ["QIRProximitySensor",          "Датчик приближени"],
        ["QLidSensor",                  "Датчик режима <Ноутбук / планшет>"],
        ["QLightSensor",                "Датчик света"],
        ["QMagnetometer",               "Магнетометр"],
        ["QOrientationSensor",          "Датчик ориентации"],
        ["QPressureSensor",             "Датчик давления"],
        ["QProximitySensor",            "Датчик приближения"],
        ["QRotationSensor",             "Датчик поворота"],
        ["QTapSensor",                  "Датчик касаний"],
        ["QTiltSensor",                 "Датчик наклона"]
    ])

    // карта уровней освещенности [значение: описание]
    property var ambientLightDesc: new Map([
       [AmbientLightReading.Undefined, "Неизвестно"],
       [AmbientLightReading.Dark, "Темно"],
       [AmbientLightReading.Twilight, "Сумерки"],
       [AmbientLightReading.Light, "Искусственный свет"],
       [AmbientLightReading.Bright, "Светло"],
       [AmbientLightReading.Sunny, "Солнечно"]
   ])

    // карта ориентации устройства
    property var orientDesc: new Map([
       [OrientationReading.Undefined, "Неизвестно"],
       [OrientationReading.TopUp, "Нормальное положение"],
       [OrientationReading.TopDown, "Перевернутое положение"],
       [OrientationReading.LeftUp, "Левым боком вверх"],
       [OrientationReading.RightUp, "Правым боком вверх"],
       [OrientationReading.FaceUp, "Экраном вверх"],
       [OrientationReading.FaceDown, "Экраном вниз"]
   ])


    function createSensor(sensorTypeName, parent) {
        // получить имя типа без Q
        var name = sensorTypeName.substr(1)
        // создать объект датчика
        var sensor = Qt.createQmlObject(
                    `import QtSensors 5.12; ${name} { id: sensor; skipDuplicates: true; active: false }`,
                    parent)
        // добавить свойства
        Object.defineProperties(sensor, {
                                    "typeName":     { value: sensorTypeName },
                                    "displayName":  { value: mapSensorTitles.get(sensorTypeName)}
                                });
        return sensor
    }


    function loadSensorPanel(sensorName, parent) {
        var panel = null
        // определить имя qml-компонента по имени датчика
        const qmlCompName = `qrc:/qml/SensorPanels/${sensorName.substr(1)}Panel.qml`
        // если компонент найден, загрузить
        if (!qmlCompName)
            return
        // создать компонент
        var comp = Qt.createComponent(qmlCompName);
        // если ОК
        if (comp.status === Component.Ready)
        {
            // создать экземпляр ...
            panel = comp.createObject(parent);
        }
        return panel
    }


    function loadSensorDetailPage(sensorName, parent) {
        var page = null
        // определить имя qml-компонента по имени датчика
        const qmlCompName = `qrc:/qml/SensorDetailPages/${sensorName.substr(1)}DetailPage.qml`
        // если компонент найден, загрузить
        if (!qmlCompName)
            return
        // создать компонент
        var comp = Qt.createComponent(qmlCompName);
        // если ОК
        if (comp.status === Component.Ready)
        {
            // создать экземпляр ...
            page = comp.createObject(parent);
            // ... и настроить
            page.title = mapSensorTitles.get(sensorName)
        }
        return page
    }


    function getAvailableSensorTypes() {
        // получить список типов доступных датчиков
//        var types = QmlSensors.sensorTypes()
        //
        // тестовый список типов датчиков
        var types = [...mapSensorTitles.keys()]
//        var types = ["QLightSensor"]
        //
        //
        // отсортировать типы датчиков
        types.sort()
        // получить список заголовков панелей (имен датчиков)
        var titles = types.map(type => mapSensorTitles.get(type))
        // вернуть 2 списка
        return {types, titles}
    }


    function getAmbientLightDesc(lightLevel) {
        return ambientLightDesc.get(lightLevel)
    }

    function getOrientDesc(orient) {
        return orientDesc.get(orient)
    }
}
