import QtQuick 2.0

Rectangle {
    id: idContainSlider
    property real value
    property real maxvalue
    signal valuechange(real value)

    MouseArea {
        id: progressArea
        anchors.fill: parent
        onClicked: (event) => {
            valuechange((event.x * maxvalue) / (idContainSlider.width - idSlider.width))        //nhat nhat lai vi tri va thoi gian khi thay doi
        }
        Rectangle{
            id: idSlider
            width: parent.height*2
            height: width
            radius: width/2
            color: "red"
            anchors.verticalCenter: parent.verticalCenter
            x: (idContainSlider.width - idSlider.width)*value/maxvalue      //nhat nhat lai vi tri va thoi gian khi thay doi
            Drag.active: progressDrag.drag.active
            onXChanged: {
                if(progressDrag.drag.active) valuechange((idSlider.x * maxvalue) / (idContainSlider.width - idSlider.width))        //nhat nhat lai vi tri va thoi gian khi thay doi
            }
            states: State {
                    when: progressDrag.drag.active
                    PropertyChanges{
                        target: idSlider
                        x: progressDrag.x
                    }
                }
            MouseArea {
                id: progressDrag
                anchors.fill: parent
                drag.target: idSlider
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: idContainSlider.width - idSlider.width
            }
        }
    }
}
