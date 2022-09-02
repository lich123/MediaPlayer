import QtQuick 2.15
import QtMultimedia
import "../mComponent"

Rectangle {
    id: root
    width: 900
    height: 600
    //tao background
    gradient: Gradient {
        GradientStop { position: 0.5; color: "lightblue" }
        GradientStop { position: 1.0; color: "darkblue" }
    }

    //tao 1 anh va cho no chuyen dong khi phat, dung khi bai hat dung
    Image {
        id: melody
        width: 250
        height: 250
//        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 300
        source: "qrc:/image/melody.png"

        PropertyAnimation{          //tao hieu ung
            id: animation;
            target: melody
            property: "rotation"
            duration: 3000
            from: 0
            to: 360
            loops: Animation.Infinite
        }
    }

    //su dung vung chua chuot de duy trif trang thai ngon ngu
    MouseArea{
        id: idMouseBG
        hoverEnabled: {
            true
            savelanguage? language.setLanguage("lang_en.qm") : language.setLanguage("lang_vi.qm")
        }
    }

    Column{
        id: idColumnMenu1
        spacing: 2
        //khi nhan vao menu se hien ra cac nut chuc nang
        MyButton{
            id: idMenu
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            Text {
                anchors.centerIn: parent
                text: qsTr("Menu")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                idLibrary.visible = !idLibrary.visible
                idOpenfolder.visible = !idOpenfolder.visible
                idOpenfile.visible = !idOpenfile.visible
                idLanguages.visible = !idLanguages.visible
                idAbout.visible = !idAbout.visible
                idVietnamese.visible = false
                idEnglish.visible = false
                idAAbout.visible = false
            }
        }
        //khi nhan vao library se chuyen sang man hinh thu 2
        MyButton{
            id: idLibrary
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("Library")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                idloader.source = "qrc:/screen/screen2.qml"
            }
        }
        // mo folder
        MyButton{
            id: idOpenfolder
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("Open Folder")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                browser.accessDirectory()
            }
        }
        //mo file
        MyButton{
            id: idOpenfile
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("Open File")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                browser.accessFile()
            }
        }
        //khi nhan Languages se hien ra 2 nut vietnammese va enghlish
        MyButton{
            id: idLanguages
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("Languages")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                idVietnamese.visible = !idVietnamese.visible
                idEnglish.visible = !idEnglish.visible
            }
        }
        //hien thithong tin ban quyen
        MyButton{
            id: idAbout
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("About")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                idAAbout.visible = !idAAbout.visible
            }
        }
    }

    //tao 1 khung hien thi thong tin app
    Rectangle{
        id: idAAbout
        width: 400
        height: 250
        visible: false
        z: 3
        anchors.centerIn: parent
        Image {
            mipmap: true
            width: 100
            height: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "qrc:/image/melody.png"
        }
        Column{
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 120
            spacing: 30
            Text {
                text: "<b>MEDIAPLAYER<\b>"
                font.pixelSize: 17
            }
            Text {
                text: "Buit by Ho Thanh Lich 26/8/2022"
                font.pixelSize: 15
            }
            Text {
                text: "<b>Version 1.0<\b>"
                font.pixelSize: 15
            }
            Text {
                text: "We will update version Beta in 30/8/2022"
                font.pixelSize: 15
            }
        }
    }

    Column{
        anchors.left: idColumnMenu1.right
        anchors.top: parent.top
        anchors.topMargin: 128
        spacing: 2
        MyButton{
            id: idVietnamese
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: "Vietnamese"
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                savelanguage = 0
                language.setLanguage("lang_vi.qm")

            }
        }
        MyButton{
            id: idEnglish
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: "English"
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                savelanguage = 1
                language.setLanguage("lang_en.qm")

            }
        }
    }

    //list view trong man hinh 1
    ListSong{
        id: idContainList
        width: 300
        height: 450
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
    }
    //thanh controll tren man hinh 1
    ControllBar{
        id: idControllBar
        width: 900
        height: 150
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }
}
