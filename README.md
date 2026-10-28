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
