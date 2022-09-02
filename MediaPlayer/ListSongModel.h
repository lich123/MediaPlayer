#ifndef LISTSONGMODEL_H
#define LISTSONGMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include "SongModel.h"


//class AbstractListModel de tao 1 listmodel tren c++
class ListSongModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum SongInfor{
        SongSource = Qt::UserRole+1,
        SongTitle,
        SongAlbum,
        SongAuthor,
    };
//    explicit ListSongModel(QObject *parent = nullptr);

    QString getsource(int index);
    Q_INVOKABLE void riceiveData(QString source, QString title, QString album, QString author);
    Q_INVOKABLE void addFavorite(int index);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int,QByteArray>roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

signals:
    QString giveSource(QString, int);
    void sendCount(int);
    void updateListData(QList<SongModel> list);
    void updateFavorite(SongModel songData);

public slots:
    void addelement(const QStringList &list){       //add tu bai duoc gui tu browser sang vao cai list
        m_listdata.clear();
        emit layoutChanged();
        for(QString temp : list)
        {
            beginInsertRows(QModelIndex(),rowCount(),rowCount());
            m_listdata.append(SongModel(temp));
            endInsertRows();
        }
    }
    void onUpdateListData(QList<SongModel> list);
    void updateIndex(int);
    void giveCount();

private:
    QList<SongModel> m_listdata;
};

#endif // LISTSONGMODEL_H
