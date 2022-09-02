#include "SongModel.h"
#include <QUrl>

SongModel::SongModel()
{

}

SongModel::SongModel(QString source){
    m_source = source;
}

SongModel::SongModel(QString source, QString title, QString album, QString author)
{
    m_source = source;
    m_title = title;
    m_album = album;
    m_author = author;
}

void SongModel::setSource(QString source){
    m_source = source;
}

QString SongModel::getSource() const
{
    return m_source;
}

void SongModel::setTitle(QString title){
    m_title = title;
}

QString SongModel::getTitle() const
{
    return m_title;
}

void SongModel::setAlbum(QString album){
    m_album = album;
}

QString SongModel::getAlbum() const
{
    return m_album;
}

void SongModel::setAuthor(QString author){
    m_author = author;
}

QString SongModel::getAuthor() const
{
    return m_author;
}
