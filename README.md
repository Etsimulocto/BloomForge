## LEGO inner-corner rounded-square Parts Bench template — build 0.1.25

- Adds **LEGO inner corner · 8×8** to the Parts Bench as an editable, closed cubic Bézier vector on the Black Cut layer.
- The profile is a **rounded square / square-circle design starter** with four cardinal anchor points and editable inner/outer Bézier handles, not a generic uneditable rectangle.
- The part is initially positioned from (26,26) to (34,34) mm, centered on (30,30), which matches the LEGO stud grid's 8 mm pitch and fixed (14,14) origin.
- Each of its four nodes and control handles is editable in Select or Nodes mode; rotation, layer, saving, SVG export, symmetry selection, and numeric dimensions use normal vector functions.
- Fixes **Duplicate** for all vector parts: clones now offset their anchors and curve handles rather than creating an overlapping vector with invalid x/y metadata.
- Reference note: earlier project SVGs **HappyJarzSVGTest1.svg** and **Bloomslice 1.0.svg** were inspected, but they did not unambiguously identify an exact LEGO inner-corner outline. This is a usable 8 mm rounded-square approximation, not a claimed exact trace of those source shapes.
- Do not assume this profile is a proven press-fit mate for LEGO studs. Check with a sacrificial cut before integrating it into production panels.

## LEGO secondary grid overlay — build 0.1.24

- **WORKSHOP → LEGO · SECONDARY GRID → Show 8 mm stud grid** toggles a pink hole-guide overlay on the canvas. It is independent of the existing 3 mm / custom drawing grid and its snap setting.
- The LEGO overlay shows **4.8 mm diameter circles** at **8 mm center-to-center spacing**, with a fixed origin at **(14, 14) mm**: the first hole center is 4 mm inside the actual sheet's top-left corner (10, 10).
- **Place / Remove Holes** activates click-to-toggle mode: click near any LEGO grid position to place a real **4.8 mm Black Cut circle**; click the same position again to remove that exact, unmodified hole.
- Placed holes are normal editable circles: move, rotate, select, duplicate, delete, save, undo and export them like other parts. Moving one off-grid means it won't be removed by the original grid point until moved back.
- The guide overlay is UI-only and **is not included in SVG cut exports**. Only holes intentionally placed into the drawing will export.
- The overlay visibility is saved with the BloomForge project JSON. It does not change existing snap resolution or cut geometry of unrelated objects.
- This uses the builder's tested 4.8 mm stud fit as the initial nominal hole diameter; machine/plywood kerf calibration is still the builder's responsibility.
- Pi Chromium rendering and physical press-fit require testing on hardware.

## Castle tab repair — build 0.1.21

- Corrected the prior 0.1.20 castle part being **invisible** because its vector object lacked a layer. New castle tabs are assigned to the black cut layer.
- Replaced the unconnected open square wave with a **single closed, symmetric 12 × 6 mm part**: two **3 × 3 mm teeth**, one at each end of a 12 mm edge, a 6 mm-wide center recess, and a 3 mm-deep backing base.
- Exact polygon in mm: `(0,0) → (3,0) → (3,3) → (9,3) → (9,0) → (12,0) → (12,6) → (0,6) → close`. No dangling endpoints. The Parts Bench thumbnail uses the same closed outline.
- Validated all edges are horizontal/vertical, left/right reflection symmetry, overall 12 × 6 mm bounds, and closed path. The teeth each measure 3 × 3 mm.
- Unlike the previous open profile, this is a **closed tab piece**. Its ends meet to form a continuous cut line. For use as an actual joining edge on a larger panel, the panel geometry must be integrated or Boolean-unioned to avoid double-cutting common edges. Confirm laser kerf and mating tolerances before cutting.

## Castle edge Parts Bench profile — build 0.1.20

- Adds **Castle edge · 12 × 3 mm** to the Parts Bench, with a matching bold square-wave thumbnail.
- Places a real editable **open vector path** measuring exactly **12 mm end-to-end** and **3 mm deep**.
- Square-wave coordinates, relative to the part origin: `(0,0) → (3,0) → (3,3) → (6,3) → (6,0) → (9,0) → (9,3) → (12,3)`. All steps use 3 mm increments.
- Node dots can be dragged in Select/Nodes mode. The part can be moved, duplicated, rotated using ROT °, saved, and exported as SVG path geometry.
- This is an **open edge profile**, not a closed cut-ready panel or a tolerance-adjusted mating joint. Integrate it into a closed panel outline and verify finger fit and laser kerf before cutting.
- Default symmetry mode for this freeform vector is Free Nodes.

## Heavier on-screen outlines & Parts Bench previews — build 0.1.19

- Canvas part outlines are rendered at **1.1 SVG drawing units**, up from **0.55** (2× on-screen width); selection highlights also double from 1.3 to 2.6. Draft paths receive heavier display strokes.
- All **Parts Bench** template buttons now show matching bold SVG outline thumbnails, including panels, holes, slots, and layer-specific guide pieces.
- **Laser SVG export intentionally remains 0.55 stroke width, as before**. Display thickness is not a kerf offset and does not change the cut path, saved geometry, or actual machine kerf.
- Grid line spacing/color/stroke remain unchanged so measurement guides do not overwhelm the drawing.
- Pi Chromium visual checks and an xTool import check remain necessary.

## Symmetry click/drag diagnosis — build 0.1.17

- **Symmetry** and **Free Nodes** controls are now pinned at the *far left of the top bar*, outside the horizontally scrolling dimension fields. They remain visible when a primitive converts to a vector.
- The right inspector explicitly reports **LOCKED · symmetric resize** or **FREE · individual nodes** for the current part.
- The bottom status area reports **Symmetry ON**, **Free Nodes ON**, **Grabbed ...**, and **SYMMETRY drag** / **FREE drag** when those actual events reach the application.
- The event readout distinguishes a missing click or node-drag event from an incorrect geometry calculation.
- This is a targeted usability and diagnostic patch, not confirmation that the Raspberry Pi mouse failure has been reproduced or resolved.

## Explicit symmetry controls — build 0.1.15

- The top bar has two separate choices: **🔒 Symmetry** and **🔓 Free Nodes**, with the active choice highlighted.
- Selecting either choice updates the selected part's constraint. You can switch back and forth repeatedly.
- The part's editable path and other properties are preserved when relocking; relocking does not undo asymmetric edits.
- Tested the state transition sequence Free → Symmetry → Free → Symmetry in isolation and confirmed that compound-vector node data remains intact. Browser pointer interaction must still be verified on Raspberry Pi.

## Symmetry-locked drag correction — build 0.1.14

- **Locked must still resize**: mirrored node drags now use the object's geometry at mouse-down rather than repeatedly adjusting from the previous pointer event.
- Opposite anchor points mirror around the original center when a closed even-node vector is locked. Unlocked vectors continue to move individual nodes.
- Dragging on a rotated vector resolves pointer coordinates against its original rotation and pivot for a stable drag.
- This addresses a suspected source of the locked-mode regression. Confirm behavior in Chromium on the Pi; no hardware mouse test has yet been completed.

# BloomForge 🪷⚒️
**Design it. Snap it. Build it.**

BloomForge is QuarterBitGames LLC's workshop-focused SVG drafting project, part of the BloomCore ecosystem.

## Target platform: Raspberry Pi desktop (Pi-first)

BloomForge is designed for a Raspberry Pi with a graphical desktop, mouse, keyboard, and Chromium. It remains browser-based internally so it can work offline on Pi without a separate native rewrite. Windows/other desktop compatibility is a secondary benefit.

**Launch on the Pi:**
```sh
git clone https://github.com/Etsimulocto/BloomForge.git
cd BloomForge
sh launch-pi.sh
```

Alternatively open `index.html` in Chromium by hand. The launcher finds `chromium` or `chromium-browser` and opens an app-style window. This is **not** a headless Pi app and is not a packaged native GUI.

Project JSON and SVG downloads currently use Chromium's normal download workflow. A future Pi-specific iteration can add a native file dialog and remembered project paths. SVG export will still be compatible with the Windows xTool cutting workstation.

Pi hardware/browser performance and laser-import accuracy have **not yet been tested**.

## First working prototype — 0.1

Open **index.html** in a modern browser. No build, installation, server, login, or internet connection is required.

Current capabilities:
- White/light, dark and wood appearance themes
- 12 × 12 inch nominal canvas and cyan 11.75 × 11.75 inch usable wood boundary (298.45 mm)
- 3 mm grid by default; preset 1 mm and 0.5 mm, editable custom spacing (0.01–1000 mm), and Free drawing without snapping
- Millimeter rulers, locked snap, selection and drag movement
- Right-side settings and bottom-right tools, left-side reusable parts bench
- Rectangle, circle, straight line, rounded slot and simple quarter-arc tools
- Four layers: Black Cut; Red Score/Etch; Green Ruler/Snap; Cyan Alt/Framing
- Inspect/edit position and geometry dimensions numerically
- Duplicate, delete, undo and redo
- Save/open **BloomForge JSON project** (editable shapes and workspace state)
- Export an **SVG with millimeter dimensions** for import into xTool Creative Space

## Symmetry Lock — build 0.1.12

- Select a part and use the **🔒 Symmetry / 🔓 Free Nodes** button in the compact top toolbar.
- **Locked:** resizing a rectangle or slot from a corner maintains its center and adjusts opposite sides evenly. Circles remain circular.
- **Unlocked:** rectangles, circles, rounded slots and lines are converted to editable SVG vector paths, permitting each node to move separately. A circle can therefore be reshaped into an asymmetric outline, not merely an ellipse.
- For an editable closed vector with an even number of points, **relocking** makes dragging an anchor or control handle move its opposite partner in the opposing direction. This is an editing constraint; it does not automatically repair a previously asymmetric shape.
- Unlocking a primitive is a **path conversion**. The resulting path exports normally and remains editable in BloomForge project JSON; Undo can restore the prior primitive immediately after conversion.
- Open line vectors and odd-node contours do not have an automatic opposite-node partner. Legacy arc editing remains limited.
- Node markers remain **0.5 mm diameter**, with separate invisible grab targets.
- Pi mouse interactions and physical xTool export still need real-device verification.

## Click-to-edit nodes — build 0.1.11

- With **Select** active, clicking a part now shows its **0.5 mm node dots** immediately; no switch to the Nodes tool is required.
- **Rectangle / slot:** drag any corner dot to change its bounds.
- **Circle:** drag the center to move it, or one of the four perimeter dots to adjust the radius.
- **Line:** drag either endpoint.
- **Arc:** drag its start and end dots (the existing simple-arc representation is retained).
- **Compound vector:** drag anchor dots and Bézier handle dots directly with Select or Nodes mode.
- Each visible dot has a separate transparent hit area, making precise small dots easier to grab. The editable geometry remains true millimeter values.
- **Nodes** mode remains available for dedicated geometry editing; clicking elsewhere with Select continues to move parts normally.
- This release adds primitive control points, not arbitrary extra control nodes on circles/rectangles; convert-to-path is a future feature.

## Compound Vector Editing — build 0.1.9 (first implementation)

- Choose **Vector** in the bottom-right tool dock. Click on the canvas to add connected straight-path nodes. Press **Enter** or double-click to finish; **Esc** cancels the in-progress path.
- Choose **Nodes** to select the finished vector and drag its node markers.
- With a vector selected, the **Position & Dimensions** sidebar offers **+ New contour**, **Toggle closed**, **Curve node**, **+ Next node**, and **Delete node**.
- **Curve node** toggles a pair of draggable cubic Bézier control handles on the active node; these can be moved separately with the mouse.
- A single vector object can contain **multiple independent open or closed contours**, saved together inside its editable BloomForge JSON project.
- Export writes the contours as a standard SVG `<path>` with `M`, `L`, `C`, and `Z` commands (without editorial node handles).
- Vector X/Y/W/H fields refer to a bounding box derived from anchors and control points. They can move and resize the path numerically.
- **Known limitations:** the first version does not yet import existing complex SVG paths, perform Boolean path unions/differences, create holes by winding rules, support arc nodes or automatic tangent smoothing, or provide full desktop vector-app parity. The bounding box uses control points as a conservative approximation, not exact extrema.
- **Validation needed on Pi:** point-selection hit targets, Bézier dragging, multiple contours, SVG exports into xTool, undo/redo and save/reopen of compound vectors. Do not cut material until these are verified.

## Cursor coordinate readout — build 0.1.8

- The compact top toolbar now shows **CURSOR X / Y** in millimeters whenever the pointer is over the SVG drawing canvas.
- The readout updates during selection, drawing, and dragging, including while zoomed or panned.
- Cursor coordinates are **actual unsnapped coordinates**, displayed to two decimals; snapping still applies to placed geometry separately.
- Moving the pointer outside the SVG clears the coordinate readout.

## Appearance Theme Studio — build 0.1.7

Open **🎨 Theme** in the compact top-right toolbar for an expanded scrollable theme editor.

- Six preset palettes: **Light, Dark, Wood, Bloom, Midnight, Blueprint**.
- Live color pickers and editable six-digit hex values for **workspace, panels, text, borders, accents, drawing paper, grid, tool buttons, button text, button borders, ruler labels, selection highlight, and sheet framing**.
- Click **Save as My Theme** to preserve a palette in the current browser's local storage. A **My Theme** preset appears immediately and on subsequent launches in that browser profile.
- **Reset Colors** restores Light; the current theme values are also included when saving BloomForge JSON project files.
- Theme and appearance colors are deliberately **separate** from the four fabrication-layer stroke colors used in SVG exports.
- Custom theme storage is local to the Pi's Chromium profile and does not sync to other computers.
- The theme menu is scrollable so it fits smaller Raspberry Pi displays.

## Compact toolbar — build 0.1.6

- The dimension inputs (selected part, X/Y, W/H) now share one compact top bar with project actions.
- **Theme** and **Export Settings** are dropdown controls on the top-right; their options are no longer in the right sidebar.
- BloomForge branding, build version and QuarterBitGames attribution have moved into the bottom status bar.
- The right sidebar retains workshop snapping, layers, object properties, and the bottom-right drawing dock.
- On narrow screens, the dimension portion of the top bar scrolls horizontally instead of hiding controls.

## Grid settings — build 0.1.5

- **3 mm** is the default manufacturing preset; **1 mm** and **0.5 mm** remain available.
- **Custom** accepts an exact numeric millimeter spacing from **0.01** through **1000** (input displayed with two decimals). Changing the numeric field switches the mode to Custom and activates snapping.
- **Free** disables coordinate snapping. The last grid spacing remains stored and the grid stays visible; to hide the grid, toggle **Show grid / sheet frame**.
- Entering an exact value in a part's numerical position/dimensions field is not snapped automatically.
- Grid mode and custom spacing are preserved in saved BloomForge projects.

## Better selecting and exact dimensions — build 0.1.4

- Click inside a rectangle, rounded slot or circle, or near the visible line of any shape, to select it.
- A **14-pixel invisible grab stroke** makes narrow cut lines easier to click. It is editor-only; exported SVG paths stay unchanged.
- A **top dimension header** shows selected object type, X, Y, width and height in millimeters, all editable.
- The **right sidebar Position & Dimensions inspector** offers the same editable numbers plus the layer selector.
- Press Enter after editing a number to apply it; no automatic grid rounding is applied to precision numeric entries.
- Circle X/Y is its **center**; circle width and height are both its **diameter**.
- Rectangles and rounded slots use top-left X/Y. Lines and current simple arcs use start-point X/Y with absolute endpoint spans for W/H.
- For a circle, editing W or H sets the shared diameter. It cannot produce an ellipse in this build.

## Canvas navigation (Pi mouse and keyboard)

- **Mouse wheel over canvas:** zoom in/out centered on the mouse cursor.
- **Ctrl + mouse wheel:** same pointer-centered zoom; prevents browser-page zoom while over the canvas.
- **Ctrl + + / Ctrl + -:** zoom around canvas center (Ctrl + Shift + = works for plus on common keyboards).
- **Ctrl + 0:** reset to 100% / full canvas view.
- **Middle mouse drag** or **hold Space and left-drag:** pan the canvas.
- **Shift + mouse wheel:** pan horizontally.
- **+ / − / Fit** controls are also in the right-hand sidebar.
- Snapping and exported measurements remain in millimeters independently of the view zoom.

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
