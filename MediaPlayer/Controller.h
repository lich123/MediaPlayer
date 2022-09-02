#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QStringList>
#include<stdlib.h>
#include<time.h>

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int index READ getIndex WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(QMediaPlayer::PlaybackState state READ getState WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(qint64 position READ getPosition WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ getDuration NOTIFY durationChanged)
    Q_PROPERTY(float volume READ getVolume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(QString currentTime READ getCurrentTime NOTIFY positionChanged)
    Q_PROPERTY(QString totalTime READ getTotalTime NOTIFY durationChanged)
    Q_PROPERTY(bool repeat READ getRepeat NOTIFY repeatChanged)
    Q_PROPERTY(bool shuffle1 READ getShuffle NOTIFY shuffleChanged)
public:
    explicit Controller(QObject *parent = nullptr);

    const int getIndex() const;
    void setIndex(const int index);

    //cac ham su dung tren thanh controll
    Q_INVOKABLE void play();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void loops();
    Q_INVOKABLE void shuffle();

    qint64 getDuration() const;     //tra ve thoi luong bai hat

    qreal getVolume() const;        //tra ve am luong bai hat
    void setVolume(const qreal volume);


    qint64 getPosition() const;     //tra ve thoi diem hien tai cua bai hat bai hat
    void setPosition(qint64 newPosition);

    QString getCurrentTime() const;

    QString getTotalTime() const;


    const QMediaPlayer::PlaybackState getState() const;
    void setState(const QMediaPlayer::PlaybackState state);

    bool getRepeat() const;

    bool getShuffle() const;

signals:
    void indexChanged(int);

    void stateChanged();

    void positionChanged();

    void durationChanged();

    void volumeChanged();

    void repeatChanged();

    void shuffleChanged();

    void takeCount();

public slots:
    void receiveSource(QString path, int index1);       //nhan source tu listmodel
    void onPlayStatusChanged(QMediaPlayer::MediaStatus status);     //ham xu ly khi bai hat doi trang thai nhu ket thuc bai hat thi se play sang stop
    void random(int value);     //ham nhan so luong cac bai hat va radom

private:
    int m_index = -1;
    QMediaPlayer mMPlayer;
    QAudioOutput *mAudio;
    QStringList m_dataSong;
    bool m_repeat = 0;
    bool m_shuffle = 0;
};

#endif // CONTROLLER_H
