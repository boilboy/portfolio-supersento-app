---
name: Modern Harmony
colors:
  surface: '#f9f9f9'
  surface-dim: '#dadada'
  surface-bright: '#f9f9f9'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f3'
  surface-container: '#eeeeee'
  surface-container-high: '#e8e8e8'
  surface-container-highest: '#e2e2e2'
  on-surface: '#1a1c1c'
  on-surface-variant: '#454652'
  inverse-surface: '#2f3131'
  inverse-on-surface: '#f1f1f1'
  outline: '#767683'
  outline-variant: '#c6c5d4'
  surface-tint: '#4c56af'
  primary: '#000666'
  on-primary: '#ffffff'
  primary-container: '#1a237e'
  on-primary-container: '#8690ee'
  inverse-primary: '#bdc2ff'
  secondary: '#75584d'
  on-secondary: '#ffffff'
  secondary-container: '#fed7ca'
  on-secondary-container: '#795c51'
  tertiary: '#001f21'
  on-tertiary: '#ffffff'
  tertiary-container: '#003638'
  on-tertiary-container: '#5aa3a7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e0e0ff'
  primary-fixed-dim: '#bdc2ff'
  on-primary-fixed: '#000767'
  on-primary-fixed-variant: '#343d96'
  secondary-fixed: '#ffdbce'
  secondary-fixed-dim: '#e4beb2'
  on-secondary-fixed: '#2b160f'
  on-secondary-fixed-variant: '#5b4137'
  tertiary-fixed: '#a6eff3'
  tertiary-fixed-dim: '#8ad3d7'
  on-tertiary-fixed: '#002021'
  on-tertiary-fixed-variant: '#004f53'
  background: '#f9f9f9'
  on-background: '#1a1c1c'
  surface-variant: '#e2e2e2'
typography:
  display-lg:
    fontFamily: Source Serif 4
    fontSize: 48px
    fontWeight: '600'
    lineHeight: 56px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Source Serif 4
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Source Serif 4
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
  headline-sm:
    fontFamily: Source Serif 4
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 32px
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Manrope
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-max: 1280px
  gutter: 24px
  margin-desktop: 64px
  margin-mobile: 20px
---

## Brand & Style
The brand personality centers on the Japanese concept of *Ma* (negative space) and the ritual of purification. It balances the heritage of communal bathing with a contemporary, high-end editorial feel. The target audience includes urban professionals seeking wellness and travelers looking for authentic cultural experiences. 

The design style is a blend of **Minimalism** and **Tactile** design. It utilizes heavy whitespace to evoke a sense of calm, paired with subtle grain textures that mimic *washi* paper to provide a physical, grounded quality. The emotional response is one of immediate decompression—inviting the user to slow down, breathe, and explore.

## Colors
The palette is rooted in the natural materials of a traditional *Sento*.
- **Deep Indigo (#1A237E):** Represents the deep evening sky and traditional *noren* curtains. Used for primary branding and high-level navigation.
- **Warm Cedar (#8D6E63):** Evokes the wooden buckets, benches, and structural elements of the bathhouse. Used for accents and secondary structural elements.
- **Steam White (#F5F5F5):** The primary background color, providing a soft, breathable canvas that feels cleaner and warmer than pure white.
- **Calming Teal (#006064):** An accent reserved for water-related information, temperature indicators, and active states.

Functional neutrals include a soft charcoal for body text to maintain high legibility without the harshness of pure black.

## Typography
This design system uses a sophisticated typographic pairing to bridge the gap between tradition and modernity. **Source Serif 4** provides an authoritative, literary quality for headlines, echoing the elegance of Japanese calligraphy. **Manrope** is used for all functional and body text; its modern, balanced proportions ensure high readability across dense review content.

For large displays, use tighter letter-spacing to maintain visual tension. Labels and small UI metadata should use increased letter-spacing and uppercase styling to provide a clear functional distinction from editorial content.

## Layout & Spacing
The layout follows a **fluid grid** model with generous inner margins to simulate the feeling of an open floor plan. 

- **Desktop:** A 12-column grid with 24px gutters. Content should be centered within a 1280px max-width container. Section vertical spacing is aggressive (80px to 120px) to allow the photography and typography to breathe.
- **Tablet:** An 8-column grid with 20px gutters and 40px side margins.
- **Mobile:** A 4-column grid with 16px gutters and 20px side margins. 

The spacing rhythm is based on a baseline of 8px. Use larger gaps for grouping sections (e.g., 64px) and smaller increments (e.g., 16px) for internal component spacing.

## Elevation & Depth
To maintain the "Modern Harmony" aesthetic, avoid heavy drop shadows. Instead, use **tonal layers** and **low-contrast outlines**.

- **Surface Levels:** The base layer is Steam White. Raised elements (like cards) use a pure white background with a 1px border in a slightly darker neutral (e.g., Cedar at 10% opacity).
- **Depth:** High-priority elements use a very soft, ambient shadow: `0 4px 20px rgba(26, 35, 126, 0.05)`. This adds a hint of Indigo to the shadow, making it feel integrated with the brand color.
- **Textures:** Apply a subtle noise overlay (2-3% opacity) to primary background sections to mimic the tactile feel of washi paper.

## Shapes
The shape language is **Rounded**, reflecting the organic nature of water and the smooth stones found in traditional baths. 

- **Standard Elements:** 0.5rem (8px) radius for buttons and input fields.
- **Cards and Containers:** 1rem (16px) radius for review cards and image containers.
- **Featured Elements:** 1.5rem (24px) for prominent call-to-outs or search bars.

Imagery should always feature slightly softened corners to prevent the UI from feeling sharp or aggressive.

## Components
- **Buttons:** Primary buttons are Solid Indigo with white text. Secondary buttons use a Cedar outline with Cedar text. Interaction states should involve a subtle shift to a more saturated version of the color, never a jarring change.
- **Chips:** Used for "Amenities" (e.g., Sauna, Cold Plunge). These should be Steam White with a 1px Cedar outline, using `label-sm` typography.
- **Review Cards:** Minimalist containers with a 1px border. The header of the card uses Source Serif 4 for the Sento name. High-quality photography should be the hero of the card.
- **Input Fields:** Clean, underlined or soft-bordered fields with Manrope body-md text. Use the Calming Teal for the focus state indicator.
- **Lists:** Lists of features or rules should use custom Cedar-colored bullet points inspired by minimalist geometric shapes.
- **Specialty Component - "Heat Level":** A custom horizontal gauge component using a gradient from Steam White to Warm Cedar to indicate the intensity or temperature of the bath experience.
