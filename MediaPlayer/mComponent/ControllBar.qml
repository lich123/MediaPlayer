import QtQuick 2.15
import QtMultimedia

Item{
    Rectangle{
        id: idcontroll
        width: 600
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        radius: 25
        color: "gray"
        //tao cac nut play, next, previous, repeat, shuffle
        MyButton{
            id: idPlay
            width: 60
            height: 60
            anchors.centerIn: parent
            property bool playing: (controll.state === 1)
            source: playing? "qrc:/image/pause.png" : "qrc:/image/play.png"
            onMyButtonClicked: {
                controll.play()
                if(playing){
                    animation.restart()
                }else{
                    animation.pause()
                }
            }
        }
        MyButton{
            id: idPrevious
            width: 50
            height: 50
            anchors.right: idPlay.left
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/back.png"
            onMyButtonClicked: {
                controll.previous()
            }
        }
        MyButton{
            id: idNext
            width: 50
            height: 50
            anchors.left: idPlay.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/next.png"
            onMyButtonClicked: {
                controll.next()
            }
        }
        MyButton{
            id: idRepeat
            width: 30
            height: 30
            anchors.right: idPrevious.left
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/repeat_icon.png"
            onMyButtonClicked: {
                controll.loops()
            }
            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.width
                radius: 5
                z: -1
                color: controll.repeat? "lightsteelblue" : "transparent"
            }
        }
        MyButton{
            id: idShuffle
            width: 30
            height: 30
            anchors.right: idRepeat.left
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/shuffle_icon.png"
            onMyButtonClicked: {
                controll.shuffle()
            }
            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.width
                radius: 5
                z: -1
                color: controll.shuffle1? "lightsteelblue" : "transparent"
            }
        }
    }

    Rectangle{
        id: idimagevolum
        width: parent.width*7/180
        height: width
        anchors.verticalCenter: idcontroll.verticalCenter
        anchors.right: idcontroll.right
        anchors.rightMargin: parent.width*31/220//180
        radius: width/2
        color: "lightsteelblue"
        Image {
            mipmap: true
            anchors.fill: parent
            source: "qrc:/image/volum.png"
        }
    }
    Slider{         //tao slider
        id: idsli
        width: 700
        height: 10
        radius: height/2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: idcontroll.top
        anchors.bottomMargin: 30
        value: controll.position
        maxvalue: controll.duration
        onValuechange: (value) =>{
                           controll.position = value
                       }
    }
    Slider{         //tao volume
        id: idvol
        width: parent.width*7/90
        height: width/10
        radius: height/2
        anchors.verticalCenter: idcontroll.verticalCenter
        anchors.left: idimagevolum.right
        anchors.leftMargin: idimagevolum.width/5
        value: controll.volume
        maxvalue: 1
        onValuechange: (value) =>{
                           controll.volume = value
                       }
    }
    //tao 1 o chua thoi gian hien tai cua bai hat
    Rectangle{
        id: totalTime
        width: parent.width*4/45
        height: width/4
        radius: height/2
        anchors.verticalCenter: idsli.verticalCenter
        anchors.left: idsli.right
        anchors.leftMargin: radius
        Text {
            anchors.centerIn: parent
            text: controll.totalTime
            font.pixelSize: 15
            color: "black"
        }
    }
    //tao 1 o chua tong thoi gian cua bai hat
    Rectangle{
        id: currentTime
        width: parent.width*4/45
        height: width/4
        radius: height/2
        anchors.verticalCenter: idsli.verticalCenter
        anchors.right: idsli.left
        anchors.rightMargin: radius
        Text {
            anchors.centerIn: parent
            text: controll.currentTime
            font.pixelSize: 15
            color: "black"
        }
    }
}
