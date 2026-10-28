# BloomForge 🪷⚒️
**Design it. Snap it. Build it.**

BloomForge is QuarterBitGames LLC's workshop-focused SVG drafting project, part of the BloomCore ecosystem.

## First working prototype — 0.1

Open **index.html** in a modern browser. No build, installation, server, login, or internet connection is required.

Current capabilities:
- White/light, dark and wood appearance themes
- 12 × 12 inch nominal canvas and cyan 11.75 × 11.75 inch usable wood boundary (298.45 mm)
- 3 mm grid by default; optional 1 mm and 0.5 mm snapping
- Millimeter rulers, locked snap, selection and drag movement
- Right-side settings and bottom-right tools, left-side reusable parts bench
- Rectangle, circle, straight line, rounded slot and simple quarter-arc tools
- Four layers: Black Cut; Red Score/Etch; Green Ruler/Snap; Cyan Alt/Framing
- Inspect/edit position and geometry dimensions numerically
- Duplicate, delete, undo and redo
- Save/open **BloomForge JSON project** (editable shapes and workspace state)
- Export an **SVG with millimeter dimensions** for import into xTool Creative Space

## First workshop test

1. Open index.html; check the canvas is light and rulers appear on top and left.
2. Choose Rect. Drag to create a panel; select it and inspect its dimensions.
3. Move the panel with snap at 3 mm increments. Switch to 1 mm and back.
4. Add a 2.5 mm circle from Parts Bench; confirm its radius is **1.25 mm** (diameter 2.5 mm).
5. Change an object's layer to Red. Hide and show that layer.
6. Save Project, reopen the JSON, then Export SVG.
7. **Verify physical dimensions and Cut/Score operations in xTool before cutting any material.** Colors alone do not automatically configure machine operations.

## Important limitations of 0.1

- The editor is a first prototype; functionality has not yet been independently browser-tested or physically laser-validated.
- Tools use simple primitives. Full Bézier/node editing, advanced arcs, collision warnings, SVG import and joint-aware snapping are future work.
- Green and cyan drawing guides are excluded from manufacturing export by default.
- The cyan sheet boundary on screen is a reference; exporting preserves the 298.45 mm sheet viewBox but does not yet warn for overhanging parts or insufficient spacing.
- The parts bench currently provides predefined templates, not editable global component records.
- Flat-panel 3D assembly, six orthographic views and box generation are not implemented.
- The nominal plywood thickness of 3 mm and minimum desired part spacing of 3 mm are design conventions; the prototype does not yet automatically enforce fit/clearance.
- Keep the original xTool/XCS source files and test new SVG exports on scrap material first.

## Next engineering milestones

**0.1 hardening:** automated geometry/snap/export tests, file validation, better arc handles, collision and out-of-bounds warnings.

**0.2:** persistent measured hardware footprints, customizable rulers and templates, SVG import and more capable path editing.

**0.3:** 3D panel assembly, six orthographic views plus perspective, mating snaps, exploded views.

**0.4:** box generation, flattening, nesting and kerf/tolerance tools.

**Development principle:** A reliable foundation and inspectable failures are more valuable than rushing to a broad feature list.
