# Random Adventure Generator

Random Adventure Generator
 
Low-Fidelity Wireframes (Text Layouts)
Home Screen
------------------------------------------------- | Random Adventure Generator | | | |
[ Give me an adventure! ] | | | | ------------------------------------------- | | | Try
a new restaurant within 5 miles | | | ------------------------------------------- | | |
| ■ (Home) ❤■ (Saved) ■■ (Categories) |
-------------------------------------------------
Categories Screen
------------------------------------------------- | Adventure Categories | | | | [
Physical ] [ Creative ] [ Social ] [ Chill ] | | | |
------------------------------------------- | | | Watch a sunset | | |
------------------------------------------- | | | | ■ (Home) ❤■ (Saved) ■■
(Categories) | -------------------------------------------------
# Random Adventure Generator — Wireframes & Mockups

This document contains the low-fidelity wireframes and high-fidelity mockup specifications for the Random Adventure Generator prototype. It is formatted for clear rendering (GitHub / VS Code preview).

## Low-fidelity wireframes (text layouts)

Below are simple, monospace wireframes that capture layout and primary interactions.

### Home screen

```
+---------------------------------------------+
| Random Adventure Generator                  |
|                                             |
|                [ Give me an adventure! ]    |
|                                             |
|  -----------------------------------------  |
|  | Try a new restaurant within 5 miles   |  |
|  -----------------------------------------  |
|                                             |
|  [ Home ]   [ Saved ]   [ Categories ]      |
---------------------------------------------+
```

Notes:
- Primary CTA: "Give me an adventure!" centered and prominent.
- Below the CTA is an example result card (single-line). Navigation is a fixed bottom bar with three icons.

### Categories screen

```
+---------------------------------------------+
| Adventure Categories                         |
|                                             |
|  [ Physical ]  [ Creative ]  [ Social ]     |
|  [ Chill ]                                     |
|                                             |
|  -----------------------------------------  |
|  | Watch a sunset                         |  |
|  -----------------------------------------  |
|                                             |
|  [ Home ]   [ Saved ]   [ Categories ]      |
---------------------------------------------+
```

Notes:
- Category chips across the top enable quick filtering. Content cards (examples) appear under the chips.

### Saved adventures screen

```
+---------------------------------------------+
| Saved Adventures                             |
|                                             |
|  ❤ Try a new restaurant within 5 miles       |
|  ❤ Visit a local museum                      |
|  ❤ Listen to a new podcast                   |
|                                             |
|  [ Home ]   [ Saved ]   [ Categories ]      |
---------------------------------------------+
```

Notes:
- Saved items show an optional heart icon and left-aligned text for readability.

## High-fidelity mockup specifications

These values capture the look-and-feel to guide visual design and CSS implementation.

### Colors

| Element            | Color        | Notes                                   |
|--------------------|--------------|-----------------------------------------|
| Background         | `#fdfdfd`    | Light beige / off-white                 |
| Buttons            | `#ffffff`    | White background with border `#333`     |
| Button border      | `#333333`    | Dark gray border                        |
| Navigation bar     | `#eeeeee`    | Light gray fixed bottom bar             |
| Active nav icon    | `#000000`    | Full opacity                            |
| Inactive nav icon  | `rgba(0,0,0,0.6)` | Faded (reduced opacity)          |

### Typography

| Element         | Style / Size              | Notes                                 |
|-----------------|---------------------------|---------------------------------------|
| Title           | Bold, 1.5rem              | Page and section titles               |
| Adventure text  | Medium (e.g., 1rem)       | Centered in result / card             |
| Saved list text | Regular, left-aligned     | Easier scanning for saved items       |

### Components

| Component     | Description                                                      |
|---------------|------------------------------------------------------------------|
| Main Button   | Prominent, rounded corners, bold border, tactile/pressable feel  |
| Adventure Box | Card-style with border, padding, and centered content            |
| Nav Bar       | Fixed to bottom, three evenly spaced icons, simple iconography   |

## Assets in this repo

- `index.html` — prototype entry point (static).
- `styles.css` — stylesheet used by the prototype.
- `Random_Adventure_Generator_Wireframes_and_Mockups.pdf` — original mockups and notes.

If you want images included in the markdown (PNG/JPG), add them to an `assets/` directory and reference them with `![alt](assets/filename.png)`.

## Implementation notes / next steps

- Convert the wireframe cards to HTML components (semantic HTML sections or `<article>` for cards).
- Add a small JavaScript module to produce random adventures and populate the Adventure Box.
- Improve accessibility: ensure buttons are keyboard-focusable and provide ARIA labels for nav icons.

---

If you'd like, I can also:
- Add a tiny `scripts.js` that implements a simple random generator and hook it into `index.html`.
- Create an `assets/` folder and export sample mockup images into it, then update this markdown with inline previews.


