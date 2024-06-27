#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "svgItems.h"

#include <QUrl>
#include <QQuickWidget>
#include <QMenu>
#include <QMouseEvent>
#include <QDebug>
#include <QCompleter>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperties>


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);



    //map
    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));
    ui->quickWidget->show();
    //nieco
    contextMenu = new QMenu(this);
    completerLineEdit =new QLineEdit(this);
    completerLineEdit->hide();

    QStringList symbols ={"nieco","niedo"};
    QStringList iconPaths = {":/Armored-Track-Unit_MGRS-Mapper.svg",":/Infantry_MGRS-Mapper.svg"};


    model = new QStandardItemModel(this);

    for(int i=0;i<symbols.size();i++){
        auto col1= new QStandardItem(QIcon(iconPaths[i]),symbols[i]);
        auto col2= new QStandardItem(symbols[i]);
        model->appendRow(QList<QStandardItem*>()<<col1<<col2);
    }

    // model->setStringList(symbols);



    completer = new QCompleter(this);
    completer-> setModel(model);

    // completer-> setCompletionMode(QCompleter::PopupCompletion);

    // completerPopup = new QListView(this);
    // completerPopup->setItemDelegate(new SvgItemDelegate(this));
    // completer->setPopup(completerPopup);

    completerLineEdit->setCompleter(completer);



    QAction *chooseSymbolAction = new QAction("Choose Symbol", this);
    connect(chooseSymbolAction,&QAction::triggered, this, &MainWindow::showCompleter);
    contextMenu->addAction(chooseSymbolAction);


}


MainWindow::~MainWindow()
{
    delete ui;
}



void MainWindow::mousePressEvent(QMouseEvent *event){
    if (event->button() == Qt::RightButton) {
        QMenu menu;
        QAction* a1 = menu.addAction(QString("test1"));
        QAction* a2 = menu.addAction(QString("test2"));
        if(a1 == menu.exec(QCursor::pos())) {


            qInfo() << "C++ a2 Info Message";
            contextMenu->exec(event->globalPos());



        }
        else if(a2 == menu.exec(QCursor::pos())) {
            qInfo() << "C++ a1 Info Message";
        }
        // menu.exec(QCursor::pos());
        qInfo() << "C++ Style Info Message";
        qInfo() << event->pos();

    }

}

void MainWindow::showCompleter(){
    completerLineEdit->move(contextMenu->pos());
    completerLineEdit->show();
    completerLineEdit->setFocus();
}
