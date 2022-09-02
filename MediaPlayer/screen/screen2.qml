import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia
import "../mComponent"
import "../Component"

Rectangle {
    id: root2
    width: 900
    height: 600
    z: -1
    //tao background
    gradient: Gradient {
        GradientStop { position: 0.5; color: "lightblue" }
        GradientStop { position: 1.0; color: "darkblue" }
    }

    //su dung vung chua chuot de duy trif trang thai ngon ngu
    MouseArea{
        id: idMouseBG
        hoverEnabled: {
            true
            savelanguage? language.setLanguage("lang_en.qm") : language.setLanguage("lang_vi.qm")
        }
    }

    Rectangle{
        id: non
        width: 700
        height: 560
        radius: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        color: "#e6ffff"
    }


    Column{
        id: idColumnMenu
        spacing: 2
        z: 2
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
                idPlayBack.visible = !idPlayBack.visible
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
            id: idPlayBack
            width: 100
            height: 30
            source: "qrc:/image/btn_orange.png"
            visible: false
            Text {
                anchors.centerIn: parent
                text: qsTr("Play Back")
                font.pixelSize: 17
            }
            onMyButtonClicked: {
                idloader.source = "qrc:/screen/screen1.qml"
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
        anchors.left: idColumnMenu.right
        anchors.top: parent.top
        anchors.topMargin: 128
        spacing: 2
        z: 2
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
    //tao cac nut abum, composer, favorites, songs
    Album{
        id: inforAlbum
        visible: false
    }
    Composer{
        id: inforComposer
        visible: false
    }
    Favorites{
        id: inforFavorites
        visible: false
    }
    Songs{
        id: inforTitle
        visible: false
    }

    Column{
        anchors.verticalCenter: parent.verticalCenter
        MyButton{
            id: buttomAlbum
            source: "qrc:/image/btn_grey.png"
            width: 150
            height: 100
            Text {
                anchors.centerIn: parent
                text: qsTr("Album")
                font.pixelSize: 20
                color: inforAlbum.visible? "red" : "White"
            }
            onMyButtonClicked: {
                inforAlbum.visible = true
                inforFavorites.visible = false
                inforComposer.visible = false
                inforTitle.visible = false
                non.visible = false
            }
        }
        MyButton{
            id: buttonComposer
            source: "qrc:/image/btn_grey.png"
            width: 150
            height: 100
            Text {
                anchors.centerIn: parent
                text: qsTr("Composer")
                font.pixelSize: 20
                color: inforComposer.visible? "red" : "White"
            }
            onMyButtonClicked: {
                inforComposer.visible = true
                inforAlbum.visible = false
                inforFavorites.visible = false
                inforTitle.visible = false
                non.visible = false
            }
        }
        MyButton{
            id: buttonFavorites
            source: "qrc:/image/btn_grey.png"
            width: 150
            height: 100
            Text {
                anchors.centerIn: parent
                text: qsTr("Favorites")
                font.pixelSize: 20
                color: inforFavorites.visible? "red" : "White"
            }
            onMyButtonClicked: {
                inforFavorites.visible = true
                inforAlbum.visible = false
                inforComposer.visible = false
                inforTitle.visible = false
                non.visible = false
            }
        }
        MyButton{
            id: buttonSongs
            source: "qrc:/image/btn_grey.png"
            width: 150
            height: 100
            Text {
                anchors.centerIn: parent
                text: qsTr("Songs")
                font.pixelSize: 20
                color: inforTitle.visible? "red" : "White"
            }
            onMyButtonClicked: {
                inforTitle.visible = true
                inforComposer.visible = false
                inforAlbum.visible = false
                inforFavorites.visible = false
                non.visible = false
            }
        }
    }
}

