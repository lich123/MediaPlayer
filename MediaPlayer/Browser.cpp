#include "Browser.h"
#include <QDebug>
#include <QDir>
#include <QString>

Browser::Browser(QWidget *parentW, QObject *parent): QObject{parent}, mDirectory(parentW)       //ham tao su dung lenh cho phep mo folder va file
{
    mDirectory.setOption(QFileDialog::ReadOnly, true);
    mDirectory.setAcceptMode(QFileDialog::AcceptOpen);
    connect(&mDirectory,&QFileDialog::accepted,this,&Browser::onaccepted);
}

void Browser::accessDirectory()     //ham mo folder
{
    mDirectory.setFileMode(QFileDialog::Directory);
    mDirectory.setDirectoryUrl(QUrl::fromLocalFile("C:/"));
    mDirectory.exec();

    QString M = mDirectory.directoryUrl().toString();
    QDir directory(mDirectory.directoryUrl().toLocalFile());
    QStringList mymusic = directory.entryList(QStringList("*mp3").toList());

    mylist.clear();
    for(const QString& name : mymusic){
        qDebug()<<(M +"/" +name);
        mylist.append(M +"/" +name);
    }

    emit sendDirectory(mylist);
}

void Browser::accessFile()      //ham cho phep mo file
{
    mDirectory.setFileMode(QFileDialog::ExistingFiles);
    mDirectory.setDirectoryUrl(QUrl::fromLocalFile("C:/"));
    mDirectory.exec();
}

void Browser::onaccepted()      // ham xu ly khi mo file va gui danh sach
{
    QStringList M = mDirectory.selectedFiles().toList();
    mylist.clear();
    mylist.append(M);
    emit sendDirectory(mylist);
}
