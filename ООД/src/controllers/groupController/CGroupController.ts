import { CShapeGroup } from "../../shapes/CShapeGroup";
import { CShapeGroupAdapter } from "../../shapes/CShapeGroupAdapter";
import { IShapeAdapter } from "../../shapes/IShapeAdapter";

interface IReturnedProps {
  adapters: IShapeAdapter[];
  selectedAdapters: IShapeAdapter[];
}

export class CGroupController {
  static GroupSelectedShapes(
    adapters: IShapeAdapter[],
    selectedAdapters: IShapeAdapter[],
  ): IReturnedProps {
    const selectedShapes = selectedAdapters
      .sort((a, b) => adapters.indexOf(a) - adapters.indexOf(b))
      .map((adapter) => adapter.GetShape());

    const group = new CShapeGroup(selectedShapes);
    const groupSelectedAdapters = [...selectedAdapters];

    const groupAdapter = new CShapeGroupAdapter(group, groupSelectedAdapters);

    adapters = adapters.filter(
      (adapter) => !selectedAdapters.includes(adapter),
    );
    adapters.push(groupAdapter);
    selectedAdapters = [groupAdapter];

    return {
      adapters,
      selectedAdapters,
    };
  }

  static UngroupSelectedShape(
    adapters: IShapeAdapter[],
    selectedAdapters: IShapeAdapter[],
  ): IReturnedProps {
    const selectedGroups: CShapeGroupAdapter[] = selectedAdapters.filter(
      (adapter) => adapter instanceof CShapeGroupAdapter,
    ) as CShapeGroupAdapter[];

    const groupAdapters = selectedGroups.flatMap((group: CShapeGroupAdapter) =>
      group.GetShapeAdapters(),
    );

    const filteredSelectedAdapters = selectedAdapters.filter(
      (adapter) => !(adapter instanceof CShapeGroupAdapter),
    );

    adapters = adapters.filter(
      (adapter) => !selectedGroups.includes(adapter as CShapeGroupAdapter),
    );

    adapters.push(...groupAdapters);
    selectedAdapters = [...filteredSelectedAdapters, ...groupAdapters];

    return {
      adapters,
      selectedAdapters,
    };
  }
}
