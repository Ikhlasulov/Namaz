const { app, BrowserWindow, ipcRenderer } = require('electron');
const path = require('path');

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    autoHideMenuBar: true,
    icon: path.join(__dirname, 'icon.png'),
    webPreferences: {
      nodeIntegration: true,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  win.setTitle("Namaz");

  win.loadFile('index.html');
}

app.whenReady().then(createWindow);
