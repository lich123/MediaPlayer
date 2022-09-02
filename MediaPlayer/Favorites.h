#ifndef FAVORITES_H
#define FAVORITES_H

#include <QAbstractListModel>
#include "SongModel.h"

    //favorites la mot cai list rong va khi co tin hieu chon thi se nhan bai hat tu listmodel gui sang va hien thi no o favorites
class Favorites : public QAbstractListModel
{
public:
    enum SongInfor{
        SongSource = Qt::UserRole+1,
        SongTitle,
        SongAlbum,
        SongAuthor,
    };
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int,QByteArray>roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
public slots:
    void onUpdateFavorite(SongModel songData);
private:
    QList<SongModel> mFavoriteList;
};

#endif // FAVORITES_H
