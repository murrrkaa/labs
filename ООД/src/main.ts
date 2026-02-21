import { app, BrowserWindow } from "electron";
import * as path from "path";

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, "renderer.js"),
      contextIsolation: false,
      nodeIntegration: true,
      devTools: true,
    },
  });

  win.loadFile("dist/index.html");

  win.webContents.openDevTools();
}

app.whenReady().then(createWindow);
