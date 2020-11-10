import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtSensors 5.12
import CommonUtils 1.0


Canvas {
    id: canvas

    property int majorMarkSize: 20
    property int minorMarkSize: 10
    property var majorMarkColor: "white"
    property var minorMarkColor: "green"
    property int arrowSize: 20
    property var arrowFillColor: "red"
    property var arrowStrokeColor: "white"
    property int itemSpacing: 10
    property int majorLetterSize: 20
    property var azimuth: 0

    property var mapPoles: new Map([
        [0,   "С"],
        [90,  "В"],
        [180, "Ю"],
        [270, "З"]
    ])

    width: 300
    height: 300

    rotation: -azimuth

    function setAzimuth(azimuth) {
        this.azimuth = (azimuth ? azimuth : 0)
        canvas.requestPaint()
    }

    onPaint: {
        // получить контекст
        var ctx = canvas.getContext("2d")
        // очистить
        ctx.reset()
        //
        // ===== Проход - 1 =====
        ctx.beginPath();
        let i = 0
        // настройки крупных насечек
        ctx.strokeStyle = majorMarkColor
        ctx.fillStyle = majorMarkColor
        ctx.font = "bold 18px serif"
        ctx.lineWidth = 3
        ctx.textAlign = "center"
        //
        for(i = 0; i < 360; i+=45) {
            // сместить начало координат в центр циферблата
            ctx.translate(width / 2, height / 2)
            // повернуть относительно центра циферблата
            ctx.rotate(i * Math.PI / 180)
            //
            // текст насечки
            const markLabel = i
            const labelX = 0
            const labelY = -height / 2 + majorLetterSize
            // отобразить текст
            if (i % 90 === 0)
                ctx.fillText(markLabel, labelX, labelY)
            //
            // позиция насечки
            const majorMarkY1 = labelY + itemSpacing
            const majorMarkY2 = majorMarkY1 + majorMarkSize
            ctx.moveTo(0, majorMarkY1)
            ctx.lineTo(0, majorMarkY2)
            //
            // полюс
            const poleLetter = mapPoles.get(i)
            if (poleLetter) {
                // сохранить контекст
                ctx.save()
                // привязать вывод текста к его центру
                ctx.textBaseline = "middle"
                // сместить контекст в центр буквы
                const poleY = majorMarkY2 + itemSpacing + 20
                ctx.translate(labelX, poleY)
                // развернуть букву в вертикальное положение
                const letterAngle = -i - canvas.rotation
                ctx.rotate((letterAngle)* Math.PI / 180)
                // отобразить букву
                ctx.fillText(poleLetter, 0, 0)
                // восстановить контекст
                ctx.restore()
            }
            // сбросить трансформации
            ctx.resetTransform()
        }
        // отрисовать буфер
        ctx.stroke()
        //
        // ===== Проход - 2 =====
        ctx.beginPath();
        // настройки мелких насечек
        ctx.strokeStyle = minorMarkColor
        ctx.fillStyle = minorMarkColor
        ctx.font = "bold 14px serif"
        ctx.lineWidth = 2
        //
        for(i = 10; i < 360; i+=10) {
            // если угол соответствует большой насечке, пропускаем
            if (i % 90 === 0)
                continue
            //
            // сместить начало координат в центр циферблата
            ctx.translate(width / 2, height / 2)
            // повернуть относительно центра циферблата
            ctx.rotate(i * Math.PI / 180)
            //
            // текст насечки
            const markLabel = i
            const labelX = 0
            const labelY = -height / 2 + majorLetterSize
            // отобразить текст
            if (i % 30 === 0)
                ctx.fillText(markLabel, labelX, labelY)
            //
            // позиция насечки
            const majorMarkY1 = labelY + itemSpacing
            const majorMarkY2 = majorMarkY1 + minorMarkSize
            ctx.moveTo(0, majorMarkY1)
            ctx.lineTo(0, majorMarkY2)
            // сбросить трансформации
            ctx.resetTransform()
        }
        // отрисовать буфер
        ctx.stroke()
        //
        // ===== Стрелка =====
        ctx.beginPath()
        // настройки мелких насечек
        ctx.strokeStyle = arrowStrokeColor
        ctx.fillStyle = arrowFillColor
        ctx.lineWidth = 1
        //
        // сместить начало координат в центр циферблата
        ctx.translate(width / 2, height / 2)
        // повернуть относительно центра циферблата
        ctx.rotate(-canvas.rotation * Math.PI / 180)
        // вернуться в начало координат
        ctx.translate(-width / 2, -height / 2)
        //
        // смещение стрелки по Y
        const arrowY = majorLetterSize + itemSpacing + minorMarkSize
        // сместить контекст
        ctx.translate(canvasSize.width / 2, arrowY)
        // нарисовать стрелку
        ctx.moveTo(0, 0)
        ctx.lineTo(-arrowSize / 2, arrowSize)
        ctx.lineTo(arrowSize / 2, arrowSize)
        // залить ...
        ctx.fill()
        // ... и отрисовать контур
        ctx.stroke()
        // сбросить трансформации
        ctx.resetTransform()
    }
}
