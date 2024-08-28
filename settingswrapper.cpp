// settingswrapper.cpp
#include "settingswrapper.h"

SettingsWrapper::SettingsWrapper(QObject *parent)
    : QObject(parent), settings("YourCompany", "Namaz")
{
}

void SettingsWrapper::setValue(const QString &key, const QVariant &value)
{
    settings.setValue(key, value);
}

QVariant SettingsWrapper::value(const QString &key, const QVariant &defaultValue)
{
    return settings.value(key, defaultValue);
}
