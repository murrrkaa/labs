import { IShapeGroup } from "./IShapeGroup";
import { IBoundingBox, IShape } from "./IShape";
import { IMemento, IShapeGroupMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export class CShapeGroup implements IShapeGroup {
  private shapes: IShape[] = [];

  constructor(shapes: IShape[]) {
    this.shapes = shapes;
  }

  ComputeArea(): number {
    return this.shapes.reduce(
      (acc, shape: IShape) => acc + shape.ComputeArea(),
      0,
    );
  }

  ComputePerimeter(): number {
    return this.shapes.reduce(
      (acc, shape: IShape) => acc + shape.ComputePerimeter(),
      0,
    );
  }

  ToFileString(): string {
    return this.shapes.map((shape) => shape.ToFileString()).join("/n");
  }

  GetBoundingBox(): IBoundingBox {
    const boxes = this.shapes.map((shape) => shape.GetBoundingBox());

    return {
      minX: Math.min(...boxes.map((box) => box.minX)),
      maxX: Math.max(...boxes.map((box) => box.maxX)),
      minY: Math.min(...boxes.map((box) => box.minY)),
      maxY: Math.max(...boxes.map((box) => box.maxY)),
    };
  }

  GetShapes(): IShape[] {
    return [...this.shapes];
  }

  SetFillColor(color: string) {
    this.shapes.forEach((shape) => shape.SetFillColor(color));
  }

  SetStrokeColor(color: string) {
    this.shapes.forEach((shape) => shape.SetStrokeColor(color));
  }

  SetStrokeWidth(width: number) {
    this.shapes.forEach((shape) => shape.SetStrokeWidth(width));
  }
  Save(): IMemento {
    return {
      shapes: this.shapes.map((shape) => shape.Save()),
    };
  }

  Restore(m: IShapeGroupMemento) {
    if (!m.shapes) return;
    m.shapes.forEach((shapeMemento, index) => {
      this.shapes[index].Restore(shapeMemento);
    });
  }

  Accept(visitor: IShapeVisitor) {
    this.shapes.forEach((shape) => shape.Accept(visitor));
  }
}
