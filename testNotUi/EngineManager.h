#ifndef ENGINEMANAGER_H
#define ENGINEMANAGER_H

#include <QQmlApplicationEngine>

class EngineManager {
public:
    static EngineManager& instance() {
        static EngineManager instance;
        return instance;
    }

    void setEngine(QQmlApplicationEngine *engine) {
        m_engine = engine;
    }

    QQmlApplicationEngine* engine() const {
        return m_engine;
    }

public:
    EngineManager() : m_engine(nullptr) {}
    ~EngineManager() = default;
    EngineManager(const EngineManager&) = delete;
    EngineManager& operator=(const EngineManager&) = delete;

    QQmlApplicationEngine *m_engine;
};

#endif // ENGINEMANAGER_H
