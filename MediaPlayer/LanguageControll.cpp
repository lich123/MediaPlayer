#include "LanguageControll.h"
#include "qtranslator.h"

LanguageControll::LanguageControll(QQmlApplicationEngine *engine, QObject *parent)
    : QObject{parent}, m_Engine(*engine)
{

}

void LanguageControll::setLanguage(QString name)
{
    QTranslator translator;
         if (translator.load(name, ":/")){
             QCoreApplication::installTranslator(&translator);
         }
         m_Engine.retranslate();
}
