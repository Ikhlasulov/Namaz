#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "settingswrapper.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(QStringLiteral(":icon.ico")));

    QQmlApplicationEngine engine;

    SettingsWrapper settingsWrapper;
    engine.rootContext()->setContextProperty("settingsWrapper", &settingsWrapper);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Namaz", "Main");

    return app.exec();
}
