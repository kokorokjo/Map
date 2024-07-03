#ifndef ENGINE_H
#define ENGINE_H
#include <QQmlApplicationEngine>
#include <QQmlEngine>


class Engine : public QQmlApplicationEngine
{
    Q_OBJECT
public:
    Engine(QQmlEngine *parent = nullptr);
    ~Engine();
};

#endif // ENGINE_H
