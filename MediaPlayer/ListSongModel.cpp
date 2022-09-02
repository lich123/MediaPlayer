#include "ListSongModel.h"

//ListSongModel::ListSongModel(QObject *parent): QObject{parent}
//{

//}

QString ListSongModel::getsource(int index)
{
    return m_listdata.at(index).getSource();
}

void ListSongModel::riceiveData(QString source, QString title, QString album, QString author)
{
    QList<SongModel> listTemp;
    SongModel item;
    item.setSource(source);
    item.setTitle(title);
    item.setAlbum(album);
    item.setAuthor(author);
    listTemp.append(item);
    for(int i = 0; i < listTemp.size(); ++i)
    {
        qDebug()<<__FUNCTION__<<listTemp[i].getSource();
        qDebug()<<__FUNCTION__<<listTemp[i].getTitle();
        qDebug()<<__FUNCTION__<<listTemp[i].getAlbum();
        qDebug()<<__FUNCTION__<<listTemp[i].getAuthor();
    }
    emit updateListData(listTemp);

}

void ListSongModel::addFavorite(int index)
{
    emit updateFavorite(m_listdata[index]);
}

int ListSongModel::rowCount(const QModelIndex &parent) const
{
    return  m_listdata.length();
}

QHash<int, QByteArray> ListSongModel::roleNames() const
{
    QHash <int,QByteArray> roles;
    roles[SongSource] = "m_source";
    return roles;
}

QVariant ListSongModel::data(const QModelIndex &index, int role) const
{
    const SongModel &item = m_listdata[index.row()];
    switch (role) {
    case SongSource:
        return item.getSource() ;
    case SongTitle:
        return item.getTitle() ;
    case SongAlbum:
        return item.getAlbum() ;
    case SongAuthor:
        return item.getAuthor() ;
    default:
        return QVariant();
    }
}

void ListSongModel::onUpdateListData(QList<SongModel> list)
{
    for(int i = 0; i < list.size(); i++)
    {
        for(int j = 0; j < m_listdata.size(); j++)
        {
            if(list[i].getSource() == m_listdata[j].getSource())
            {
                if(m_listdata[j].getTitle() == "")
                {
                    m_listdata[j].setTitle(list[i].getTitle());
                }
                if(m_listdata[j].getAlbum() == "")
                {
                    m_listdata[j].setAlbum(list[i].getAlbum());
                }
                if(m_listdata[j].getAuthor() == "")
                {
                    m_listdata[j].setAuthor(list[i].getAuthor());
                }
                goto doNothing;
            }
        }
        m_listdata.append(list[i]);
        doNothing:{}
    }
    for(int i = 0; i < m_listdata.size(); ++i)
    {
        qDebug()<<__FUNCTION__<<m_listdata[i].getSource();
        qDebug()<<__FUNCTION__<<m_listdata[i].getTitle();
        qDebug()<<__FUNCTION__<<m_listdata[i].getAlbum();
        qDebug()<<__FUNCTION__<<m_listdata[i].getAuthor();
    }
    qDebug() << __FUNCTION__ << m_listdata.size();
}

void ListSongModel::updateIndex(int index)
{
    if(index >= rowCount()){
        emit giveSource(getsource(0), index);
    }else if(index < 0){
        emit giveSource(getsource(rowCount()-1), index);
    }else{
        emit giveSource(getsource(index), index);
    }
}

void ListSongModel::giveCount()
{
    emit sendCount(rowCount()-1);
}
