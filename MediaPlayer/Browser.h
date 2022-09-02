#ifndef BROWSER_H
#define BROWSER_H

#include <QObject>
#include <QFileDialog>
#include <QStringList>

class Browser : public QObject
{
    Q_OBJECT
public:
    explicit Browser(QWidget *parentW = nullptr, QObject *parent = nullptr);

    Q_INVOKABLE void accessDirectory();         //tao 1 ham de mo folder
    Q_INVOKABLE void accessFile();          //tao 1 ham de cho phep mo file

signals:
    void sendDirectory(QStringList);            //tao 1 tin hieu de gui danh sach source cac bai hat
public slots:
    void onaccepted();          //tao ham de gui danh sach source di
private:
    QFileDialog mDirectory;
    QStringList mylist;
};

#endif // BROWSER_H
