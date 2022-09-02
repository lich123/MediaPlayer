#ifndef LANGUAGECONTROLL_H
#define LANGUAGECONTROLL_H

#include <QObject>
#include <QCoreApplication>
#include <QQmlApplicationEngine>

 //class de cap nhat ngon ngu
class LanguageControll : public QObject
{
    Q_OBJECT
public:
    explicit LanguageControll(QQmlApplicationEngine *engine, QObject *parent = nullptr);

        Q_INVOKABLE void setLanguage(QString name);

private:
    QQmlApplicationEngine &m_Engine;

};

#endif // LANGUAGECONTROLL_H
