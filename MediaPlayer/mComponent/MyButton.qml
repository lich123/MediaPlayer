import QtQuick 2.15
import QtQuick.Window 2.15

Image {
    mipmap : true
    signal myButtonClicked()
    scale: mouse.pressed ? 0.8 : 1
    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: myButtonClicked()
    }
}
