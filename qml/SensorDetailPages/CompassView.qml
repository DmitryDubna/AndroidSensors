//import QtQuick 2.12
//import QtQuick.Controls 2.12
//import QtQuick.Window 2.12
//import QtQuick.Layouts 1.12
//import QtGraphicalEffects 1.12
//import QtSensors 5.12
//import CommonUtils 1.0


//Canvas {
//    id: canvas

//    property int dialSize: Math.min(width, height)
//    property int majorMarkSize: 20
//    property int minorMarkSize: 10
//    property var majorMarkColor: "white"
//    property var minorMarkColor: "green"
//    property int arrowSize: 20
//    property var arrowFillColor: "red"
//    property var arrowStrokeColor: "white"
//    property int itemSpacing: 10
//    property int majorLetterSize: 20
//    property var azimuth: 0

//    property var mapPoles: new Map([
//                                       [0,   "С"],
//                                       [45,  "СВ"],
//                                       [90,  "В"],
//                                       [135, "ЮВ"],
//                                       [180, "Ю"],
//                                       [225, "ЮЗ"],
//                                       [270, "З"],
//                                       [315, "СЗ"]
//                                   ])

//    width: 300
//    height: 300

//    rotation: -azimuth


//    function setAzimuth(azimuth) {
//        this.azimuth = (azimuth ? azimuth : 0)
//        canvas.requestPaint()
//    }


//    function drawCompass() {
//        // получить контекст
//        var ctx = canvas.getContext("2d")
//        // очистить
//        ctx.reset()
//        // деления градусов
//        drawDegreeMarks(ctx)
//        // большие насечки
//        drawMajorMarks(ctx)
//        // маленькие насечки
//        drawMinorMarks(ctx)
//        // стрелка
//        drawArrow(ctx)
//        // значение компаса
//        drawValue(ctx)
//    }


//    function drawDegreeMarks(ctx) {
//        ctx.beginPath();
//        // настройки
//        ctx.strokeStyle = "gray"
//        ctx.lineWidth = 0.5
//        //
//        for(let i = 0; i < 360; i+=1) {
//            // сместить начало координат в центр циферблата
//            ctx.translate(width / 2, height / 2)
//            // повернуть относительно центра циферблата
//            ctx.rotate(i * Math.PI / 180)
//            //
//            // позиция насечки
//            const majorMarkY1 = -dialSize / 2 + majorLetterSize + itemSpacing
//            const majorMarkY2 = majorMarkY1 + majorMarkSize
//            ctx.moveTo(0, majorMarkY1)
//            ctx.lineTo(0, majorMarkY2)
//            // сбросить трансформации
//            ctx.resetTransform()
//        }
//        // отрисовать буфер
//        ctx.stroke()
//    }


//    function drawMajorMarks(ctx) {
//        ctx.beginPath();
//        // настройки крупных насечек
//        ctx.strokeStyle = majorMarkColor
//        ctx.fillStyle = majorMarkColor
//        ctx.font = "bold 18px serif"
//        ctx.lineWidth = 3
//        ctx.textAlign = "center"
//        //
//        for(let i = 0; i < 360; i+=45) {
//            // сместить начало координат в центр циферблата
//            ctx.translate(width / 2, height / 2)
//            // повернуть относительно центра циферблата
//            ctx.rotate(i * Math.PI / 180)
//            //
//            // текст насечки
//            const markLabel = i
//            const labelX = 0
//            const labelY = -dialSize/*height*/ / 2 + majorLetterSize
//            // отобразить текст
//            if (i % 90 === 0)
//                ctx.fillText(markLabel, labelX, labelY)
//            //
//            // позиция насечки
//            const majorMarkY1 = labelY + itemSpacing
//            const majorMarkY2 = majorMarkY1 + majorMarkSize
//            ctx.moveTo(0, majorMarkY1)
//            ctx.lineTo(0, majorMarkY2)
//            //
//            // полюс
//            const poleLetter = mapPoles.get(i)
//            if (poleLetter) {
//                // сохранить контекст
//                ctx.save()
//                // привязать вывод текста к его центру
//                ctx.textBaseline = "middle"
//                // сместить контекст в центр буквы
//                const poleY = majorMarkY2 + itemSpacing + 20
//                ctx.translate(labelX, poleY)
//                // развернуть букву в вертикальное положение
//                const letterAngle = -i - canvas.rotation
//                ctx.rotate((letterAngle)* Math.PI / 180)
//                // шрифт
//                const fontSize = (poleLetter.length === 1 ? 18 : 12)
//                ctx.font = `bold ${fontSize}px serif`
//                // отобразить букву
//                ctx.fillText(poleLetter, 0, 0)
//                // восстановить контекст
//                ctx.restore()
//            }
//            // сбросить трансформации
//            ctx.resetTransform()
//        }
//        // отрисовать буфер
//        ctx.stroke()
//    }


//    function drawMinorMarks(ctx) {
//        ctx.beginPath();
//        // настройки мелких насечек
//        ctx.strokeStyle = minorMarkColor
//        ctx.fillStyle = minorMarkColor
//        ctx.font = "bold 14px serif"
//        ctx.lineWidth = 3
//        //
//        for(let i = 10; i < 360; i+=10) {
//            // если угол соответствует большой насечке, пропускаем
//            if (i % 90 === 0)
//                continue
//            //
//            // сместить начало координат в центр циферблата
//            ctx.translate(width / 2, height / 2)
//            // повернуть относительно центра циферблата
//            ctx.rotate(i * Math.PI / 180)
//            //
//            // текст насечки
//            const markLabel = i
//            const labelX = 0
//            const labelY = -dialSize / 2 + majorLetterSize
//            // отобразить текст
//            if (i % 30 === 0)
//                ctx.fillText(markLabel, labelX, labelY)
//            //
//            // позиция насечки
//            const majorMarkY1 = labelY + itemSpacing
//            const majorMarkY2 = majorMarkY1 + minorMarkSize
//            ctx.moveTo(0, majorMarkY1)
//            ctx.lineTo(0, majorMarkY2)
//            // сбросить трансформации
//            ctx.resetTransform()
//        }
//        // отрисовать буфер
//        ctx.stroke()
//    }


//    function drawArrow(ctx) {
//        ctx.beginPath()
//        // настройки мелких насечек
//        ctx.strokeStyle = arrowStrokeColor
//        ctx.fillStyle = arrowFillColor
//        ctx.lineWidth = 1
//        //
//        // сместить начало координат в центр циферблата
//        ctx.translate(width / 2, height / 2)
//        // повернуть относительно центра циферблата
//        ctx.rotate(-canvas.rotation * Math.PI / 180)
//        // вернуться в начало координат
//        ctx.translate(-dialSize/*width*/ / 2, -dialSize/*height*/ / 2)
//        //
//        // смещение стрелки по Y
//        const arrowY = majorLetterSize + itemSpacing + minorMarkSize
//        // сместить контекст
//        ctx.translate(dialSize/*canvasSize.width*/ / 2, arrowY)
//        // нарисовать стрелку
//        ctx.moveTo(0, 0)
//        ctx.lineTo(-arrowSize / 2, arrowSize)
//        ctx.lineTo(arrowSize / 2, arrowSize)
//        // залить ...
//        ctx.fill()
//        // ... и отрисовать контур
//        ctx.stroke()
//        // сбросить трансформации
//        ctx.resetTransform()
//    }


//    function drawValue(ctx) {
//        ctx.beginPath()
//        // настройки
//        ctx.strokeStyle = "white"
//        ctx.fillStyle = "white"
//        ctx.lineWidth = 2
//        ctx.font = "bold 30px serif"
//        ctx.textAlign = "center"
//        ctx.textBaseline = "middle"
//        //
//        // сместить начало координат в центр циферблата
//        ctx.translate(width / 2, height / 2)
//        // повернуть относительно центра циферблата
//        ctx.rotate(-canvas.rotation * Math.PI / 180)
//        // фигура в центре
//        ctx.ellipse(-50, -50, 100, 100, 0, 0, 2 * Math.PI);
//        // значение в центре
//        ctx.fillText(`${azimuth}°`, 0, 0)
//        // ... и отрисовать контур
//        ctx.stroke()
//        // сбросить трансформации
//        ctx.resetTransform()
//    }


//    onPaint: drawCompass()
//}






import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtSensors 5.12
import CommonUtils 1.0


Item {
    property int dialSize: Math.min(width, height)
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
                                      [45,  "СВ"],
                                      [90,  "В"],
                                      [135, "ЮВ"],
                                      [180, "Ю"],
                                      [225, "ЮЗ"],
                                      [270, "З"],
                                      [315, "СЗ"]
                                  ])
    width: 300
    height: 300

//    rotation: -azimuth

//    function setAzimuth(azimuth) {
//        this.azimuth = (azimuth ? azimuth : 0)
////        canvas.requestPaint()
//    }

    onAzimuthChanged: {
        canvas.requestPaint()
    }



    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -azimuth

        function drawCompass() {
            // получить контекст
            var ctx = canvas.getContext("2d")
            // очистить
            ctx.reset()
            // деления градусов
            drawDegreeMarks(ctx)
            // большие насечки
            drawMajorMarks(ctx)
            // маленькие насечки
            drawMinorMarks(ctx)
//            // стрелка
//            drawArrow(ctx)
            // значение компаса
            drawValue(ctx)
        }


        function drawDegreeMarks(ctx) {
            ctx.beginPath();
            // настройки
            ctx.strokeStyle = "gray"
            ctx.lineWidth = 0.5
            //
            for(let i = 0; i < 360; i+=1) {
                // сместить начало координат в центр циферблата
                ctx.translate(width / 2, height / 2)
                // повернуть относительно центра циферблата
                ctx.rotate(i * Math.PI / 180)
                //
                // позиция насечки
                const majorMarkY1 = -dialSize / 2 + majorLetterSize + itemSpacing
                const majorMarkY2 = majorMarkY1 + majorMarkSize
                ctx.moveTo(0, majorMarkY1)
                ctx.lineTo(0, majorMarkY2)
                // сбросить трансформации
                ctx.resetTransform()
            }
            // отрисовать буфер
            ctx.stroke()
        }


        function drawMajorMarks(ctx) {
            ctx.beginPath();
            // настройки крупных насечек
            ctx.strokeStyle = majorMarkColor
            ctx.fillStyle = majorMarkColor
            ctx.font = "bold 18px serif"
            ctx.lineWidth = 3
            ctx.textAlign = "center"
            //
            for(let i = 0; i < 360; i+=45) {
                // сместить начало координат в центр циферблата
                ctx.translate(width / 2, height / 2)
                // повернуть относительно центра циферблата
                ctx.rotate(i * Math.PI / 180)
                //
                // текст насечки
                const markLabel = i
                const labelX = 0
                const labelY = -dialSize/*height*/ / 2 + majorLetterSize
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
                    // шрифт
                    const fontSize = (poleLetter.length === 1 ? 18 : 12)
                    ctx.font = `bold ${fontSize}px serif`
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
        }


        function drawMinorMarks(ctx) {
            ctx.beginPath();
            // настройки мелких насечек
            ctx.strokeStyle = minorMarkColor
            ctx.fillStyle = minorMarkColor
            ctx.font = "bold 14px serif"
            ctx.lineWidth = 3
            //
            for(let i = 10; i < 360; i+=10) {
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
                const labelY = -dialSize / 2 + majorLetterSize
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
        }


        function drawValue(ctx) {
            ctx.beginPath()
            // настройки
            ctx.strokeStyle = "white"
            ctx.fillStyle = "white"
            ctx.lineWidth = 2
            ctx.font = "bold 30px serif"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            //
            // сместить начало координат в центр циферблата
            ctx.translate(width / 2, height / 2)
            // повернуть относительно центра циферблата
            ctx.rotate(-canvas.rotation * Math.PI / 180)
            // фигура в центре
            ctx.ellipse(-50, -50, 100, 100, 0, 0, 2 * Math.PI);
            // значение в центре
            ctx.fillText(`${(Math.round(azimuth) + 360) % 360}°`, 0, 0)
            // ... и отрисовать контур
            ctx.stroke()
            // сбросить трансформации
            ctx.resetTransform()
        }


        onPaint: drawCompass()
    }


    Canvas {
        id: canvasArrow

        anchors.fill: parent


        function drawArrow() {
            // получить контекст
            var ctx = canvasArrow.getContext("2d")
            // очистить
            ctx.reset()
            //
            ctx.beginPath()
            // настройки мелких насечек
            ctx.strokeStyle = arrowStrokeColor
            ctx.fillStyle = arrowFillColor
            ctx.lineWidth = 1
            //
            // сместить начало координат в центр циферблата
            ctx.translate(width / 2, height / 2)
            //
            // смещение стрелки по Y
            const arrowY = -dialSize / 2 + majorLetterSize + itemSpacing + minorMarkSize
            // сместить контекст
            ctx.translate(0, arrowY)
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

        onPaint: drawArrow()
    }
}

