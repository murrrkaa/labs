import { IShape, ShapeTypeKeys, ShapeTypeEnum } from "./IShape";
import { IShapeProcessor } from "./IShapeProcessor";
import * as fs from "fs";
import { CTriangle } from "./CTriangle";
import { CRectangle } from "./CRectangle";
import { CCircle } from "./CCircle";
import { IPoint } from "./IPoint";
import { ENCODING } from "../constants/constants";

export class CShapeProcessor implements IShapeProcessor {
  private shapes: IShape[] = [];

  private shapeParsers: Record<ShapeTypeEnum, (params: string[]) => IShape> = {
    CIRCLE: (params) => this.ParseCircle(params),
    TRIANGLE: (params) => this.ParseTriangle(params),
    RECTANGLE: (params) => this.ParseRectangle(params),
  };

  constructor() {}

  GetShapes(): IShape[] {
    return this.shapes;
  }

  ReadShapesFromFile(filename: string) {
    const text = fs.readFileSync(filename, ENCODING);
    const lines: string[] = text?.split("\n");
    this.ParseShapes(lines);
  }

  WriteInfoShapesToFile(filename: string) {
    const lines = this.shapes.map((shape) => shape.ToFileString());
    fs.writeFileSync(filename, lines.join("\n"), ENCODING);
  }

  private ParseShapes(lines: string[]): void {
    lines.forEach((line) => {
      const shapeType: ShapeTypeKeys = this.GetShapeType(line);
      const params = this.ParseParams(line, shapeType);
      const shape = this.shapeParsers[shapeType](params);
      this.shapes.push(shape);
    });
  }

  private ParseTriangle(params: string[]): IShape {
    const [p1, p2, p3] = this.ParseMultiplePoints(params, 3);
    return new CTriangle(p1, p2, p3);
  }

  private ParseRectangle(params: string[]): IShape {
    const [p1, p2] = this.ParseMultiplePoints(params, 2);
    return new CRectangle(p1, p2);
  }

  private ParseCircle(params: string[]): CCircle {
    const [center] = this.ParseMultiplePoints(params, 1);
    const radius = Number(params[1].split("=")[1]);
    return new CCircle(center, radius);
  }

  private ParseParams(line: string, shapeType: ShapeTypeKeys): string[] {
    return line
      .replace(`${shapeType}`, "")
      .split(";")
      .map((item) => item.trim());
  }

  private ParsePoint(point: string): IPoint {
    const [x, y] = point.split("=")[1].split(",").map(Number);
    return { x, y };
  }

  private ParseMultiplePoints(points: string[], count: number): IPoint[] {
    return points.slice(0, count).map((point) => this.ParsePoint(point));
  }

  private GetShapeType(line: string): ShapeTypeKeys {
    return line.split(":")[0] as ShapeTypeKeys;
  }
}
