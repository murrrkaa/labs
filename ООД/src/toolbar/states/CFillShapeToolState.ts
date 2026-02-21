import { CApplication } from "../../app/CApplication";
import { IToolbarState } from "./IToolbarState";
import { CFillShapeState } from "../../canvas/states/CFillShapeState";

export class CFillShapeToolState implements IToolbarState {
  constructor(private app: CApplication) {}

  Select(): void {
    this.app.State = new CFillShapeState(this.app);
  }
}
