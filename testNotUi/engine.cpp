#include "engine.h"

#include <QQmlEngine>

QT_BEGIN_NAMESPACE
namespace En {
class Engine;
}
QT_END_NAMESPACE

Engine::Engine(QQmlEngine *parent)
    : QQmlApplicationEngine(parent)
{



}

Engine::~Engine(){

}
