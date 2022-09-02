#include "Favorites.h"

int Favorites::rowCount(const QModelIndex &parent) const
{
    return  mFavoriteList.length();
}

QHash<int, QByteArray> Favorites::roleNames() const
{
    QHash <int,QByteArray> roles;
    roles[SongSource] = "m_source";
    roles[SongTitle] = "m_title";

    return roles;
}

QVariant Favorites::data(const QModelIndex &index, int role) const
{
    const SongModel &item = mFavoriteList[index.row()];
    switch (role) {
    case SongTitle:
        return item.getTitle() ;
    default:
        return QVariant();
    }
}

void Favorites::onUpdateFavorite(SongModel songData)
{
    mFavoriteList.append(songData);
//    qDebug() << __FUNCTION__ << list.size();
//    mFavoriteList = list;
    for(int i = 0; i < mFavoriteList.count(); ++i)
    {
        qDebug() << __FUNCTION__ << i + 1 << mFavoriteList[i].getTitle();
        qDebug() << __FUNCTION__ << i + 1 << mFavoriteList[i].getAuthor();
        qDebug() << __FUNCTION__ << i + 1 << mFavoriteList[i].getSource();
    }
}
