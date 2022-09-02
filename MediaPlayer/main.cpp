#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Browser.h"
#include "Controller.h"
#include "Favorites.h"
#include "LanguageControll.h"
#include "ListSongModel.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    //tao cac doi tuong cua cac lop
    Browser browser;
    ListSongModel receivelist;
    Controller controller;
    Favorites myFavorites;

    QObject::connect(&browser, &Browser::sendDirectory, &receivelist, &ListSongModel::addelement);      //connect tin hieu gui danh sach source slot nhan danh sach sang abtraclistmodel
    QObject::connect(&controller, &Controller::indexChanged, &receivelist, &ListSongModel::updateIndex);        //connect tin hieu de nhan index tu controll sang listmodel de set cai source dung voi index do
    QObject::connect(&receivelist, &ListSongModel::giveSource, &controller, &Controller::receiveSource);        //gui source tu listmodel dung index sang lai controll

    QObject::connect(&controller, &Controller::takeCount, &receivelist, &ListSongModel::giveCount);        //connect tin hieu lay so luong trong danh sach
    QObject::connect(&receivelist, &ListSongModel::sendCount, &controller, &Controller::random);        //connect tin hieu gui de gui so luong phan tu sang controll de thuc hien shuffle
    QObject::connect(&receivelist, &ListSongModel::updateListData, &receivelist, &ListSongModel::onUpdateListData);     //connect tin de gui tin hieu danh sach data sang ham thucj thi
    QObject::connect(&receivelist, &ListSongModel::updateFavorite, &myFavorites, &Favorites::onUpdateFavorite);     //connect tin hieu de gui index cua fi=avorites sang listmodel


    QQmlApplicationEngine engine;

    LanguageControll language(&engine);

    //dang ky ten de su dung duoi qml
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("browser", &browser);
    context->setContextProperty("receivelist", &receivelist);
    context->setContextProperty("controll", &controller);
    context->setContextProperty("language", &language);
    context->setContextProperty("myFavorites", &myFavorites);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
