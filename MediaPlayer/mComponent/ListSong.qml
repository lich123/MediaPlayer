import QtQuick 2.15
import QtMultimedia

Rectangle {
    radius: 15
    color: "#e6ffff"
    //hien thi list cac bai hat
    ListView{
        width: 300
        height: 300
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.left: parent.left
        spacing: 5
        model: receivelist
        currentIndex: controll.index
        delegate: Rectangle{
            width: 290
            height: 30
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: focus? "yellow" : "transparent"
            Rectangle{
                id: rect
                width: 250
                height: 30
                border.width: 3
                border.color: "#0000cc"
                radius: 10
                clip: true
                anchors.left: parent.left
                scale: mousehoverList.containsMouse? 1.1 : 1
                color: "transparent"//focus? "yellow" : "transparent"
                Text {
                    id: name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 7
                    text: idmediaPlay.metaData.stringValue(MediaMetaData.Title) //hien thi title bai hat
                    color: "#0000cc"
                    onTextChanged: { //dua du lieu len c++
                        receivelist.riceiveData(idmediaPlay.source.toString(),
                                                idmediaPlay.metaData.stringValue(MediaMetaData.Title),
                                                idmediaPlay.metaData.stringValue(MediaMetaData.AlbumTitle),
                                                idmediaPlay.metaData.stringValue(MediaMetaData.Author));
                    }
                }
                MouseArea{
                    id: mousehoverList
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        controll.index = index //cap nhat index len c++ de xu ly
                        controll.play()
                    }
                }
                MediaPlayer{
                    id: idmediaPlay
                    source: m_source
                }
            }
            Image {
                width: 30
                height: 30
                anchors.right: parent.right
                source: "qrc:/image/favorites.png"
            }
            Rectangle{
                width: 30
                height: 30
                anchors.right: parent.right
                z: 3
                color: idMouseFavo.focus? "transparent" : "#e6ffff"
                MouseArea{
                    id: idMouseFavo
                    anchors.fill: parent
                    onClicked: {
                        idMouseFavo.focus = !idMouseFavo.focus
                        receivelist.addFavorite(index)
                    }
                }
            }
        }
    }
}
