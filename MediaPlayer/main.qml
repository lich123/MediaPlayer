import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 900
    height: 600
    visible: true
    title: qsTr("Music For Life")

    property bool savelanguage: false

    //man hinh window se tai man hinh 1
    Loader {
        id: idloader
        source: "qrc:/screen/screen1.qml"
    }
}
