import { IShapeAdapter } from "../../shapes/IShapeAdapter";

export class CSelectionController {
  static SelectionShape(
    e: MouseEvent,
    cursorX: number,
    cursorY: number,
    adapters: IShapeAdapter[],
    selectedAdapters: IShapeAdapter[],
  ): IShapeAdapter[] {
    let newSelected: IShapeAdapter[] = [...selectedAdapters];
    let clickedAdapter: IShapeAdapter | null = null;

    for (let i = adapters.length - 1; i >= 0; i--) {
      const adapter = adapters[i];
      if (adapter.IsPointInside({ x: cursorX, y: cursorY })) {
        clickedAdapter = adapter;
        break;
      }
    }

    if (clickedAdapter) {
      if (e.shiftKey) {
        if (!newSelected.includes(clickedAdapter)) {
          newSelected.push(clickedAdapter);
        }
      } else {
        newSelected = [clickedAdapter];
      }
    } else {
      newSelected = [];
    }

    return newSelected;
  }
}
