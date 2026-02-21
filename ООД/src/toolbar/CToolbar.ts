import { IToolbarState } from "./states/IToolbarState";
import { CApplication } from "../app/CApplication";
import { ShapeTypeEnum } from "../shapes/IShape";
import { CAddShapeToolState } from "./states/CAddShapeToolState";
import { CDragShapeToolState } from "./states/CDragShapeToolState";
import { CFillShapeToolState } from "./states/CFillShapeToolState";
import {
  APP_FILL_COLOR,
  APP_STROKE_COLOR,
  EVENT_CHANGE,
  EVENT_CLICK,
  EVENT_KEYDOWN,
} from "../constants/constants";
import { CIdleState } from "../canvas/states/CIdleState";
import { ISaveStrategy } from "../strategy/ISaveStrategy";
import { CBinarySaveStrategy } from "../strategy/CBinarySaveStrategy";
import { ShapeSaver } from "../strategy/CShapeSaver";
import { CTextSaveStrategy } from "../strategy/CTextSaveStrategy";
import { CShapeLoaderTemplate } from "../template/CShapeLoaderTemplate";
import { CTextShapeLoader } from "../template/CTextShapeLoader";
import { CBinaryShapeLoader } from "../template/CBinaryShapeLoader";

export class CToolbar {
  private currentTool: IToolbarState | null = null;
  private shapeSelect: HTMLSelectElement;
  private strokeColorInput: HTMLInputElement;
  private fillColorInput: HTMLInputElement;
  private lineWidthSelect: HTMLSelectElement;
  private modeSelect: HTMLSelectElement;

  private fillColorInputCheckbox: HTMLInputElement;
  private strokeColorInputCheckbox: HTMLInputElement;

  private saveButton: HTMLButtonElement;
  private saveFormatSelect: HTMLSelectElement;

  private loadInput: HTMLInputElement;

  constructor(private app: CApplication) {
    this.shapeSelect = document.getElementById(
      "shape-type",
    ) as HTMLSelectElement;
    this.strokeColorInput = document.getElementById(
      "stroke-color",
    ) as HTMLInputElement;
    this.fillColorInput = document.getElementById(
      "fill-color",
    ) as HTMLInputElement;
    this.lineWidthSelect = document.getElementById(
      "line-width",
    ) as HTMLSelectElement;
    this.modeSelect = document.getElementById("mode") as HTMLSelectElement;

    this.fillColorInputCheckbox = document.getElementById(
      "fill-enabled",
    ) as HTMLInputElement;

    this.strokeColorInputCheckbox = document.getElementById(
      "stroke-enabled",
    ) as HTMLInputElement;

    this.saveButton = document.getElementById("save-btn") as HTMLButtonElement;

    this.saveFormatSelect = document.getElementById(
      "save-format",
    ) as HTMLSelectElement;

    this.loadInput = document.getElementById("load-file") as HTMLInputElement;

    this.initEventListeners();
  }

  private initEventListeners() {
    this.shapeSelect.addEventListener(EVENT_CHANGE, () => {
      this.app.CurrentShapeType = this.shapeSelect.value as ShapeTypeEnum;
    });

    this.strokeColorInput.addEventListener(EVENT_CHANGE, () => {
      this.app.StrokeColor = this.strokeColorInput.value;
    });

    this.fillColorInput.addEventListener(EVENT_CHANGE, () => {
      this.app.FillColor = this.fillColorInput.value;
    });

    this.lineWidthSelect.addEventListener(EVENT_CHANGE, () => {
      const width = parseInt(this.lineWidthSelect.value);
      if (!isNaN(width)) this.app.StrokeWidth = width;
    });

    this.modeSelect.addEventListener(EVENT_CHANGE, () =>
      this.ChangeMode(this.modeSelect.value),
    );

    this.fillColorInputCheckbox.addEventListener(EVENT_CHANGE, () => {
      if (this.fillColorInputCheckbox.checked) {
        this.app.FillColor = APP_FILL_COLOR;
        this.fillColorInput.value = "";
        this.fillColorInput.disabled = true;
      } else {
        this.fillColorInput.disabled = false;
      }
    });

    this.strokeColorInputCheckbox.addEventListener(EVENT_CHANGE, () => {
      if (this.strokeColorInputCheckbox.checked) {
        this.app.StrokeColor = APP_STROKE_COLOR;
        this.strokeColorInput.value = "";
        this.strokeColorInput.disabled = true;
      } else {
        this.strokeColorInput.disabled = false;
      }
    });

    document.addEventListener(EVENT_KEYDOWN, (e) => {
      if (e.ctrlKey && e.key.toLowerCase() === "z") {
        this.app.Undo();
      }
    });

    this.saveButton.addEventListener(EVENT_CLICK, () => {
      const format = this.saveFormatSelect.value;
      const shapes = this.app
        .GetCanvasManager()
        .GetAdapters()
        .map((a) => a.GetShape());

      let strategy: ISaveStrategy;
      if (format === "text") strategy = new CTextSaveStrategy();
      else strategy = new CBinarySaveStrategy();

      const saver = new ShapeSaver(strategy);
      saver.SaveShapes(shapes, `shapes.${format === "text" ? "txt" : "bin"}`);
    });

    this.loadInput.addEventListener(EVENT_CHANGE, async () => {
      if (!this.loadInput.files?.length) return;

      const file = this.loadInput.files[0];
      const fileName = file.name.toLowerCase();
      const isText = fileName.endsWith(".txt");
      const isBinary = fileName.endsWith(".bin");

      if (!isText && !isBinary) {
        alert("Неверный формат файла. Допустимо .txt или .bin");
        return;
      }

      let data: string | ArrayBuffer = isText
        ? await file.text()
        : await file.arrayBuffer();

      let loader: CShapeLoaderTemplate = isText
        ? new CTextShapeLoader()
        : new CBinaryShapeLoader();

      const shapes = loader.Load(data);
      this.app.GetCanvasManager().DrawShapes(shapes);
    });
  }

  private ChangeMode(value: string) {
    switch (value) {
      case "add":
        this.SetMode(new CAddShapeToolState(this.app));
        break;
      case "drag":
        this.SetMode(new CDragShapeToolState(this.app));
        break;
      case "fill":
        this.SetMode(new CFillShapeToolState(this.app));
        break;
      default:
        this.app.State = new CIdleState(this.app);
    }
  }

  SetMode(tool: IToolbarState) {
    this.currentTool = tool;
    tool.Select();
  }
}
