import QtQuick 2.15
import QtMultimedia
import "../mComponent"

Rectangle {     //hien list cac bai hat cua danh sach
    width: 700
    height: 560
    radius: 20
    anchors.top: parent.top
    anchors.topMargin: 20
    anchors.right: parent.right
    anchors.rightMargin: 20
    color: "#e6ffff"
    ListView{
        width: 680
        height: 450
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        model: receivelist
        currentIndex: controll.index
        delegate: Rectangle{
            width: 680
            height: 50
            border.width: 3
            border.color: "#0000cc"
            radius: 15
            clip: true
            scale: mousehover.containsMouse? 1.1 : 1
            color: focus? "yellow" : "transparent"
            Text {
                id: infor
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 7
                text: mediaPlay.metaData.stringValue(MediaMetaData.Title)
                font.pixelSize: 17
                color: "#0000cc"
            }
            MouseArea{
                id: mousehover
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    controll.index = index
                    controll.play()
                }
            }
            MediaPlayer{
                id: mediaPlay
                source: m_source
            }
        }
    }
}
