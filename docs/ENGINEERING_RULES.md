# BloomForge engineering rules

- User workflow: left parts bench, center measured canvas, all working controls on the right with drawing tools bottom-right.
- Material: nominal 3 mm plywood. Physical wood boundary 11.75 in (298.45 mm); 12 in nominal workspace.
- Snapping defaults to 3 mm. Object positions snap; precision geometry such as 2.5 mm holes must retain exact dimensions.
- Design coordinates and SVG export units are millimeters; do not infer precision from display decimal formatting.
- Four user-defined categories: Black/Cut, Red/Score-Etch, Green/Ruler-Snap, Cyan/Alt-Framing. These are *design conventions*; operation assignment happens in xTool.
- Green/cyan guides should not accidentally become fabrication instructions.
- Distinguish editable project state from exported SVG geometry.
- Project-specific and global components will eventually include measured mounting footprint, revision, physical verification and design provenance.
- Every new geometric behavior needs regression tests, including snapping disabled, fractional hole diameters, SVG round trips, and negative coordinates.
- 3D panel views will eventually derive from one shared model, never seven copies.

## Known immediate follow-ups

1. Validate first prototype in Chromium/Edge.
2. Add a read-only full SVG-import path before trying to round-trip complex existing fabrication files.
3. Add warnings for off-sheet shapes and cut spacing under 3 mm.
4. Improve arc representation and node/Bezier editing.
5. Add true parts-bench staging and editable library definitions.
