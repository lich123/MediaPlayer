#ifndef SONGMODEL_H
#define SONGMODEL_H

#include <QString>

class SongModel
{
public:
    SongModel();
    SongModel(QString source);
    SongModel(QString source, QString title, QString album, QString author);


    //cac phuong thuc set va get cua du lieu bai hat
    void setSource(QString source);
    QString getSource()const;

    void setTitle(QString title);
    QString getTitle()const;

    void setAlbum(QString album);
    QString getAlbum()const;

    void setAuthor(QString author);
    QString getAuthor()const;

    void setCoverart(QString coverart);
    QString getCoverart()const;


private:
    QString m_source;
    QString m_title;
    QString m_album;
    QString m_author;
};

#endif // SONGMODEL_H
