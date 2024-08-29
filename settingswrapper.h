// settingswrapper.h
#ifndef SETTINGSWRAPPER_H
#define SETTINGSWRAPPER_H

#include <QObject>
#include <QSettings>

class SettingsWrapper : public QObject
{
    Q_OBJECT

public:
    explicit SettingsWrapper(QObject *parent = nullptr);

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant());

private:
    QSettings settings;
};

#endif // SETTINGSWRAPPER_H
