#include "Controller.h"
#include "qdatetime.h"
#include <QDebug>
#include <QTime>
#include <QTranslator>
using namespace std;

Controller::Controller(QObject *parent)
    : QObject{parent}
{
    mAudio = new QAudioOutput;

    QObject::connect(&(this->mMPlayer), SIGNAL(playbackStateChanged(QMediaPlayer::PlaybackState)), this, SIGNAL(stateChanged()));
    QObject::connect(&(this->mMPlayer), SIGNAL(mediaStatusChanged(QMediaPlayer::MediaStatus)),this, SLOT(onPlayStatusChanged(QMediaPlayer::MediaStatus)));
    QObject::connect(&this->mMPlayer, &QMediaPlayer::positionChanged, this, &Controller::positionChanged);
    QObject::connect(&this->mMPlayer, &QMediaPlayer::durationChanged, this, &Controller::durationChanged);
    QObject::connect(this->mAudio, &QAudioOutput::volumeChanged, this, &Controller::volumeChanged);

    mAudio->setVolume(0.5);
    mMPlayer.setAudioOutput(mAudio);
}

const int Controller::getIndex() const
{
    return m_index;
}

void Controller::setIndex(const int index)
{
    if (m_index != index){
        m_index = index;
    }
    emit indexChanged(m_index);
}

void Controller::next()
{
    emit indexChanged(++ m_index);
    if (!mMPlayer.source().isEmpty())
        mMPlayer.play();
}

void Controller::previous()
{
    emit indexChanged(-- m_index);
    if (!mMPlayer.source().isEmpty())
        mMPlayer.play();
}

void Controller::receiveSource(QString path, int index1)
{
    mMPlayer.setSource(path);
    mMPlayer.play();
}

void Controller::onPlayStatusChanged(QMediaPlayer::MediaStatus status)
{
    if(status == QMediaPlayer::EndOfMedia){
        if(m_repeat){
            emit indexChanged(m_index);
        }else if(m_shuffle){
            emit takeCount();
            emit indexChanged(m_index);
        }else{
            emit indexChanged(++ m_index);
        }
    }
}

void Controller::random(int value)
{
        srand(time(0));
        m_index = rand() % value + 1;
}

void Controller::play()
{
    if(mMPlayer.playbackState() != QMediaPlayer::PlayingState){
        mMPlayer.play();
    }
    else mMPlayer.pause();
}

qreal Controller::getVolume() const
{
    return mAudio->volume();
}

void Controller::setVolume(const qreal volume)
{
    if(volume != mAudio->volume()){
        mAudio->setVolume(volume);
        emit volumeChanged();
    }
}

qint64 Controller::getPosition() const
{
    return mMPlayer.position();
}

void Controller::setPosition(qint64 newPosition)
{
    if (newPosition != mMPlayer.position()){
        mMPlayer.setPosition(newPosition);
    }
}
qint64 Controller::getDuration() const
{
    return mMPlayer.duration();
}


QString Controller::getCurrentTime() const
{
    long long int ms = getPosition() % 1000;
    long long int s = (getPosition()/1000)%60;
    long long int m = (getPosition()/1000)/60;
    long long int h = m/60;
    return QTime(h, m, s, ms).toString("hh:mm:ss");
}

QString Controller::getTotalTime() const
{
    long long int ms = getDuration() % 1000;
    long long int s = (getDuration()/1000)%60;
    long long int m = (getDuration()/1000)/60;
    long long int h = m/60;
    return QTime(h, m, s, ms).toString("hh:mm:ss");
}

const QMediaPlayer::PlaybackState Controller::getState() const
{
    return mMPlayer.playbackState();
}

void Controller::setState(const QMediaPlayer::PlaybackState state)
{
    if (state != mMPlayer.playbackState())
        emit stateChanged();
}

bool Controller::getRepeat() const
{
    return m_repeat;
}

void Controller::loops()
{
    m_repeat ^= 0x01;
    emit repeatChanged();
}

void Controller::shuffle()
{
    m_shuffle ^= 0x01;
    qDebug()<<__FUNCTION__<<m_shuffle;
    emit shuffleChanged();
    emit takeCount();
}

bool Controller::getShuffle() const
{
    return m_shuffle;
}
