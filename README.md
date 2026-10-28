# BloomForge 🪷⚒️

**Design it. Snap it. Build it.**

**Current build: 0.1.33** · QuarterBitGames LLC · Offline, Raspberry Pi-first SVG drafting for laser-cut plywood and LEGO-compatible mounting patterns.

BloomForge is a self-contained `index.html` editor that runs in a graphical Chromium desktop on Raspberry Pi. Design in **millimeters**, arrange parts on an **11.75 × 11.75 in (298.45 × 298.45 mm)** wood sheet reference, save editable JSON projects, and export SVG for **xTool Creative Space (XCS)**. A 12 × 12 in nominal canvas surrounds the usable-sheet boundary.

> **Fabrication safety:** The visual canvas is not a cut simulation. Imported SVG colors do not configure machine operations automatically. Verify scale, Cut/Score assignments, open paths, duplicate/overlapping cuts, minimum bridges, and kerf in XCS. Test new joints and stud fits on scrap first.

## Launch and update

**First launch on a Raspberry Pi with desktop, keyboard, mouse and Chromium:**

```sh
git clone https://github.com/Etsimulocto/BloomForge.git
cd BloomForge
sh launch-pi.sh
```

**Update an existing checkout:**

```sh
cd ~/BloomForge
git pull
sh launch-pi.sh
```

Alternatively open `index.html` directly in a modern desktop browser. There is **no build step, server, sign-in or Internet requirement** for editing. The Pi launcher opens Chromium in an app-style window, not a native packaged GUI or headless service. JSON and SVG files download through Chromium; keep copies of your designs.

## Raspberry Pi home-screen shortcut and app icon

BloomForge includes a **one-command desktop shortcut installer** and a fallback SVG icon. To use the **neon lotus icon generated in ChatGPT**, first download the file named **`BloomForge-icon.png`** from the conversation on the Raspberry Pi and save it in **`~/Downloads/`**.

Then run:

```sh
cd ~/BloomForge
git pull
sh install-desktop.sh
```

The installer makes a **BloomForge.desktop** shortcut on `~/Desktop` (when that folder exists) and registers BloomForge in `~/.local/share/applications`. It uses `~/Downloads/BloomForge-icon.png` as the icon when present; otherwise it uses the bundled `bloomforge-icon.svg` fallback. It copies the downloaded PNG to `~/.local/share/icons/bloomforge.png` so the launcher continues working after Downloads is cleaned.

The launcher starts `launch-pi.sh` and opens BloomForge in its own Chromium application window. On some Raspberry Pi OS desktops, the first run may ask you to **Allow Launching / Execute** the shortcut. No root privileges or system-wide changes are required. Re-running the installer refreshes the shortcut and icon.

**Note:** Changing GitHub files does not itself put the shortcut on a powered-on Raspberry Pi; you must run the installer on that Pi. The full-size neon artwork is shared through ChatGPT as a PNG, not embedded in the Git repository.

## Current tool map

| Area | Tools / behavior |
| --- | --- |
| **Top toolbar** | Selected part's exact X/Y/W/H in mm, rotation 0–360°, cursor coordinates; **🔒 Symmetry / 🔓 Free Nodes**; Theme, Export Settings, New, Save, Open, Export |
| **Parts Bench (left)** | Hole, slot, tab, panel, castle/finger-joint, LEGO stud-relief and LEGO corner templates with outline previews |
| **Workshop (right)** | 3/1/0.5 mm or custom grid, Free drawing, snap, zoom/pan, four layer visibility/color pickers, secondary LEGO stud guide and hole placement |
| **Precision Geometry (right)** | Numeric **Angle °**, **Length mm**, and **Fillet radius mm**; Apply to selected line and Round selected node |
| **Tools (bottom right)** | Select, Rect, Circle, Line, Slot, Arc, Vector, Nodes, **✂ Cut Line**, **📐 Angle Line** |
| **Inspector (right)** | Position, dimensions, layer and vector contour/node editing controls |

### Exact angle lines and radius fillets (0.1.33)

**Create a 17° line:** Enter `17` in **Angle °** and your desired **Length mm** (e.g. `30`), choose **📐 Angle Line**, then click its start position on the canvas. **0° goes right; +90° goes up**. Decimal and negative angles work. The start follows the active woodworking snap; the calculated end uses precise coordinates **without snapping away the requested angle**.

**Change an existing straight line:** Select a Line, change Angle ° / Length mm, then click **Apply to selected line**. Its starting position is preserved. This does not automatically constrain arbitrary vector edges.

**Round a vector corner:** Select a vector, use **Nodes**, click a sharp anchor point, enter a **Fillet radius mm** (e.g. `3`), then press **Round selected node**. The two neighboring edges must be straight and long enough; otherwise the operation is refused. The corner is replaced by a cubic Bézier approximation of a circular fillet. Radius is **not a permanent parametric constraint** after you edit its nodes. Chamfer, angle-between-edges constraints and custom arc sweep are **not implemented**.

### Compound vectors and Cut Line

- **Vector:** click successive points; press **Enter** or double-click to finish; **Esc** cancels a draft. Use **Nodes** or **Select** to edit anchors and Bézier handles. A vector may contain multiple open or closed contours.
- **✂ Cut Line:** select an existing vector by clicking its outline, then click a **line segment** or an individual **node** to delete it. Cutting a closed contour opens it; cutting an open segment splits it into two contours. Node deletion reconnects neighboring points. **Undo / Redo** records the edits.
- **Symmetry vs Free Nodes:** symmetric primitive resize keeps opposing bounds coordinated; unlocking a primitive can convert it to a compound vector. Closed even-node vectors may mirror opposite node motions. Relocking does not repair earlier asymmetric geometry.
- **Caution:** Opening a contour does **not** automatically reconnect it to another contour or form a usable panel perimeter. Boolean union, welded joins and full SVG import are not yet available.

### LEGO-compatible grid and Bench parts

- **Show 8 mm stud grid** overlays **4.8 mm** nominal hole guides on **8 mm center-to-center pitch**, independent of the usual 3 mm woodworking grid. Its origin is fixed at **(14,14) mm** in drawing coordinates, 4 mm inside the wood boundary.
- **Place / Remove Holes** mode toggles real 4.8 mm **Black Cut** circle geometry at LEGO guide positions. Unused guide circles **never export**.
- **LEGO stud relief · 8×8:** closed eight-node cell with inward corner reliefs around four stud centers.
- **LEGO corner notch · 4 mm arms:** open quarter-round edge; its two endpoints stop halfway between studs. Newly placed corners snap their stud pivot to 8 mm grid centers and rotate around that pivot.
- **LEGO 2×2 corner · 3 holes:** a **16 × 16 mm** L-pattern part with three closed **4.8 mm** cut-hole contours on **8 mm** pitch and an **open** outer stepped edge. Its **left and bottom perimeter lines are intentionally absent**. W/H numeric resizing is disabled to protect hole spacing and diameter; vector nodes remain editable.
- **Castle corner · 3×3×3×3:** **12 mm** open square-wave edge at **3 mm** pitch/depth, including a **3 mm vertical left connector**.
- The experimental **LEGO end corner · mitred 8 mm** was **removed from the Bench** in 0.1.31. Older saved shapes of that type may still load; the current Bench does not offer new copies.

A user's proven **4.8 mm** LEGO stud press fit is the working hole default, **not a guarantee for other wood, kerf, or machines**. Tiling templates may produce shared/overlapping cut segments; the editor does not yet Boolean-union them.

### Grid, layers, appearance and export

- **Drawing grid:** 3 mm default, 1 mm, 0.5 mm, custom 0.01–1000 mm or **Free**; toggle snap and drawing guides independently.
- **Four fabrication layers:** **Black · Cut**, **Red · Score/Etch**, **Green · Guides**, **Cyan · Framing**. Layer visibility and drawing layer selection live in the sidebar.
- **Theme Studio:** Light, Dark, Wood, Bloom, Midnight and Blueprint, plus custom interface color settings. Four **display-only layer swatches** are editable beside the layer controls **and** under Theme. Dark theme defaults make Black Cut outlines light enough to see; saved projects remember layer swatch overrides.
- **Export colors stay canonical**, regardless of the displayed swatches: Black `#222222`, Red `#d74141`, Green `#269b4d`, Cyan `#02a7c3`. Display line weight is thicker than export stroke width; **neither visually thick lines nor color changes compensate kerf**. Export Settings can include Red Score/Etch and optionally Green/Cyan; guide overlays and editor handles are not manufacturing paths.
- **Navigation:** mouse wheel zoom, Ctrl+wheel zoom, middle-button or Space+drag pan, Shift+wheel horizontal pan, Ctrl++ / Ctrl+- zoom, Ctrl+0 fit.
- **Save/Open:** editable BloomForge v1 JSON containing shapes and workspace state. SVG export uses mm units with the 298.45 mm sheet viewBox.

## Current limitations and validation

BloomForge's JavaScript syntax and selected pure geometry calculations have been checked during development, but **the complete current build has not been independently regression-tested in Pi Chromium or physically validated against XCS and the laser**. Test the selection/click targets, complicated vector contours, fillets, save/reopen, export, rotations, and operation mapping on the actual workstation.

No automatic Boolean union/difference, multi-path join, collision/out-of-sheet warning, guaranteed kerf compensation, joint fit validation, editable parametric fillet constraint, advanced SVG import, or 3D assembly is implemented yet. The simple Arc tool is not the same as an exact-radius/start/sweep CAD arc editor. Where an item below describes a previous build, its wording is historical and **may have been superseded** by later corrections.

## Development history (newest first)

The entries below retain engineering notes from prior versions, including experiments that were later changed or removed. **Use the current feature guide above for authoritative 0.1.33 behavior.**

---

## Precision Angle & Radius — build 0.1.33

- Adds **PRECISION GEOMETRY** controls in the right sidebar for numeric **angle (degrees)**, **line length (mm)**, and **fillet radius (mm)**.
- Select **📐 Angle Line** from the bottom-right tools, then click the canvas to place a straight Black/Red/Green/Cyan-layer line at the exact entered angle and length. **0° points right and +90° points up** (counterclockwise), positive or negative decimal degrees supported. The start uses the selected drawing snap; the computed endpoint bypasses snap to preserve precise angle and length.
- **Apply to selected line** rewrites the endpoint of an ordinary existing Line while preserving its original starting point, with undo/redo support.
- **Round selected node**: select an existing vector, choose the **Nodes** tool, click a corner node, enter a numeric radius (e.g., **R3 mm**) and apply. The tool replaces that corner with two tangent points joined by a cubic Bézier circular-arc approximation; adjacent straight edges stay straight. Works with acute/obtuse interior angles, subject to enough clearance on both adjacent legs.
- Fillets are intentionally refused at a path endpoint, for already-curved adjacent segments, for nearly straight/180-degree corners, or where the requested radius would overlap the next node. The original vector is preserved on a failed operation.
- Undo/redo and SVG export retain the new geometry. All fabricator color mappings and existing LEGO/castle parts remain unchanged.
- Angle endpoint coordinates are rounded to 0.001 mm. The fillet is a standard cubic approximation to the true circular arc, not an SVG-native arc primitive or a persistent parametric radius constraint; free-node edits can change it later. Numeric radius may be re-applied to other selected sharp corners.
- Test Pi Chromium selection and verify the xTool SVG before cutting. **Chamfer, angle-between-edges constraint, and numeric arc sweep** are planned, not part of this build.

## Four editable display-layer swatches and dark-theme contrast — build 0.1.32

- Adds editable color pickers for **Black Cut, Red Score/Etch, Green Guides, and Cyan Framing** beside the four layers and under **Theme → FOUR LAYER DISPLAY COLORS**. Both sets of pickers stay synchronized.
- **Dark, Midnight, and Blueprint** themes default to a bright `#f4f7fb` Black Cut outline against dark drawing paper; custom dark canvas colors also get an automatic light Black Cut default.
- Changes are **display-only**: the canvas and Parts Bench preview strokes use the chosen screen colors. The SVG export deliberately retains canonical Black `#222222`, Red `#d74141`, Green `#269b4d`, and Cyan `#02a7c3` to keep laser operation-color mapping stable.
- User overrides apply across theme switching until **Reset layer display colors** is clicked. Overrides are saved as `state.layerColors` in BloomForge project JSON and restored on project open; older projects with no overrides still work.
- Theme palette CSS settings remain separate from fabrication display swatches. No shape, cutting geometry, or laser export stroke width is changed.
- Test Black Cut visibility in dark themes and confirm your machine's SVG operation assignment before cutting.

## Open 2×2 LEGO corner and Cut Line tool — build 0.1.31

- Removes **LEGO end corner · mitred 8 mm** from the Parts Bench (existing placed/saved objects of that type continue to load). Other corner templates are retained.
- The **LEGO 2×2 corner · 3 holes** is now an **open outer edge**: no left outside line and no bottom outside line. Its remaining edge travels from upper-left to upper-middle, down/around the rounded inner step, along the step to the right, and down the outer right edge. The other **three 4.8 mm holes remain complete closed contours**, with the same 8 mm pitch.
- Adds **✂ Cut Line** tool (bottom-right). Select a vector by clicking its outline, then click any vector **segment** to remove that segment or any visible **node** to remove that point. The tool also works on curved contours and on other compound vector parts; it does not indiscriminately delete every path in a compound object.
- On **closed contours**, deleting an edge opens the ring at that edge, preserving all remaining segments. On **open contours**, deleting an edge splits it into two open contours. Deleting a node removes that node and reconnects neighbors directly; if a contour becomes too short it is removed. Undo/Redo snapshots are taken before cuts.
- Cut tool exposes oversized transparent hit paths for easy clicking and node targets draw above the segment hit paths. The actual cut geometry is unchanged except for the explicitly deleted segments/nodes.
- Open cut contours are **not standalone closed panel perimeters**. Join/combine them into a closed outline before treating them as a complete part cut.
- Confirm interaction in Raspberry Pi Chromium and inspect SVG export in xTool before laser cutting.

## Photo-based 2×2 LEGO corner with three holes — build 0.1.30

- Adds **LEGO 2×2 corner · 3 holes** to the Parts Bench. The previous 4-way stud relief, half-pitch corner, end corner, and castle parts are preserved.
- One compound Black Cut vector with **four closed contours**: a stepped **L-shaped outside perimeter** and **three 4.8 mm diameter hole contours**. The upper-right fourth-stud location is open/cut away.
- Nominal **16 × 16 mm** LEGO 2×2 footprint with **8 mm hole center pitch**. Default overall SVG bounds: `(26,26)`–`(42,42)`; stud holes centered at `(30,30)`, `(30,38)`, `(38,38)`. The corner normally occupied by the fourth stud `(38,30)` is cut away.
- The L-shaped cutout turns through a **2.4 mm-radius cubic Bézier inside corner**. This is an inferred design from the supplied photograph, not a dimensional trace.
- As one vector, the part can be selected, rotated (pivot on stud `(30,30)`), moved with 8 mm LEGO stud-grid snapping, duplicated with 8 mm offset, saved and exported.
- W/H resize fields are disabled on this specific fixed-size pattern to protect the **4.8 mm holes** and **8 mm spacing**. Individual nodes and Bézier handles remain editable through the Nodes tool for custom geometry.
- Cutting caution: the outline and all three holes are actual fabrication cuts; check xTool import, kerf, minimum bridge material, and physical LEGO press-fit on scrap before production.

## Full-pitch LEGO mitred end corner — build 0.1.29

- Adds **LEGO end corner · mitred 8 mm** to the Parts Bench; preserves both the four-way stud-relief tile and the 4 mm half-pitch corner notch.
- The new open vector starts with a nominal **2.4 mm radius** stud-center relief, reaches the full **8 mm** LEGO pitch, clips the outside corner with a **1 × 1 mm, 45° mitre**, continues to the 8 mm end, then returns 4 mm along the adjacent edge.
- Initial points relative to pivot (30,30): `(0,4) → (0,2.4) [Bezier] → (2.4,0) → (7,0) → (8,1) → (8,8) → (4,8)`. One connected open path, Black Cut layer.
- The stud pivot is shared with the shorter LEGO corner template: **numeric rotation pivots around the stud center, dragging/X-Y snaps that pivot to 8 mm LEGO grid centers, and duplication offsets by 8 mm**.
- Width/height numeric edits preserve the 2.4 mm stud radius and 1 mm, 45-degree mitre while lengthening straight segments; free-node edits remain available. Minimum edited dimensions 4 mm.
- The uploaded photograph is a visual reference for the stepped end feature, not a dimensional drawing; the **1 mm mitre and 4 mm return** are editable initial design assumptions. Check physical placement and kerf before production cutting.
- This is an **open edge**, intended to be connected into a complete cut perimeter.

## Half-pitch LEGO corner alignment — build 0.1.28

- Corrects **LEGO corner notch** to use **two 4 mm arms** (half the 8 mm LEGO stud pitch), with a nominal **2.4 mm stud-relief radius**. The shape is still an open four-node Bézier curve and the existing four-way stud-relief tile is preserved.
- The new part's stud pivot is at **(30,30) mm**, a LEGO stud-grid center. Its initial endpoints are **(30,34)** and **(34,30)**; each is 4 mm from the stud center. The curved relief runs between **(30,32.4)** and **(32.4,30)**.
- Rotation **uses the stud pivot**, rather than the visual bounding-box center. Four duplicates rotated 0/90/180/270 degrees meet in four exact shared midpoints around the stud.
- **Dragging in Select mode snaps the stud pivot to the nearest 8 mm LEGO stud center**, independent of the existing woodworking grid. X/Y numeric positioning also rounds to the stud grid. Duplicate offsets the pivot and geometry by **8 mm** instead of 3 mm.
- Optional width/height edits still extend the straight arms while keeping the 2.4 mm circular corner radius, with minimum width and height 2.4 mm. Changing W/H away from 4 mm deliberately breaks midpoint-to-midpoint connection and should be used only for special designs.
- This requires **newly placed** corner-notch parts, which carry the stud pivot metadata; existing saved v0.1.27 notch parts remain loadable but lack the automatic grid pivot. Real laser kerf and fit remain fabrication concerns.

## Photo-based LEGO corner notch — build 0.1.27

- Adds **LEGO corner notch · 8×8** as a distinct Parts Bench template. Keeps the earlier **LEGO stud relief · 8×8** untouched.
- Inspired by the stepped, rounded **outer-end corner cutout** visible in the builder's wood mounting bar photograph; **does not** add the entire bar, slots, or mounting holes.
- Open four-node vector: straight vertical leg → quarter-circle inward bend → straight horizontal leg, initial width/height **8×8 mm**, with nominal **2.4 mm** corner radius (4.8 mm stud reference). The photograph does not establish exact measured notch dimensions; these are editable defaults.
- **Stretching via the W/H numeric fields** maintains the 2.4 mm radius while lengthening the straight legs. Moving via X/Y fields preserves the profile; node editing is freeform.
- Black Cut layer; rotated, duplicated, saved, exported as an open SVG path. Because it is an open edge profile, it must be incorporated into a complete connected outline for production cutting.

## LEGO stud-center relief tile — build 0.1.26

- Replaces the 0.1.25 **LEGO inner corner** Bench template with **LEGO stud relief · 8×8**, an 8 mm grid-cell shape whose four corners are NOT rounded outward; they are cut INWARD to leave stud clearance.
- The four hypothetical studs sit at the square's corners: (30,30), (38,30), (38,38), (30,38) mm, which match the secondary LEGO grid centers (origin 14 mm, pitch 8 mm).
- Each removed corner follows a nominal **quarter-circle relief of 2.4 mm radius**, corresponding to the builder's tested **4.8 mm stud diameter**. The resulting connected part has four inward arcs separated by 3.2 mm straight edge segments and is a closed SVG cut outline.
- The vector contains **eight anchor nodes, two per relieved corner**, and editable Bézier controls. Exact circular quarter-arcs are represented with standard cubic Bézier approximation (kappa ≈0.55228475).
- The bench thumbnail derives from the same vector geometry; the Black Cut part can be moved, rotated, resized, duplicated, and SVG-exported. Its width and height are 8 mm.
- IMPORTANT: Holes/circles and relief tiles are separate cut geometry. Avoid overlapping cut operations. The tile itself is one 8 mm cell; assembling multiple cells into a larger continuous panel needs connected path editing/Boolean union, not double-cutting shared outlines.
- Actual laser kerf means 4.8 mm nominal relief may require small clearance adjustments for real-world cut fit; test on scrap before production.

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
