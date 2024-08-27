#ifndef CLOCKMANAGER_H
#define CLOCKMANAGER_H

#include <QObject>
#include <QDateTime>
#include <QTimeZone>

class ClockManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY timeChanged)

public:
    explicit ClockManager(QObject *parent = nullptr) : QObject(parent) {
        // Initialize with the default timezone
        setTimeZone("UTC"); // Default to UTC
    }

    QString currentTime() const {
        return QDateTime::currentDateTime().toTimeZone(timeZone).toString("hh:mm:ss");
    }

public slots:
    void setTimeZone(const QString &zone) {
        timeZone = QTimeZone(zone.toUtf8());
        emit timeChanged();
    }

signals:
    void timeChanged();

private:
    QTimeZone timeZone;
};

#endif // CLOCKMANAGER_H
