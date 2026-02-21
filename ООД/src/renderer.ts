import { INPUT_FILE_NAME, OUTPUT_FILE_NAME } from "./constants/constants";
import { CApplication } from "./app/CApplication";
import { CToolbar } from "./toolbar/CToolbar";

export const main = () => {
  const app = CApplication.GetInstance();

  app.Toolbar = new CToolbar(app);

  const processor = app.GetShapeProcessor();
  const canvasManager = app.GetCanvasManager();

  processor.ReadShapesFromFile(INPUT_FILE_NAME);
  const shapes = processor.GetShapes();

  canvasManager.DrawShapes(shapes);

  processor.WriteInfoShapesToFile(OUTPUT_FILE_NAME);
};

document.addEventListener("DOMContentLoaded", main);
