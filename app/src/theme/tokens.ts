/** Design tokens from docs/03-art-style.md (baseline: clownfish "橘橘"). */
export const colors = {
  primary: '#FF7A2E',
  primaryDeep: '#E2622A',
  ink: '#1D3640',
  muted: '#5B7680',
  paper: '#F3F8F9',
  surface: '#FFFFFF',
  line: '#D5E4E8',
  chip: '#E8F2F4',
  outline: '#2B1D1A',

  seaTop: '#5FD3E8',
  seaMid: '#2FB2D4',
  seaBottom: '#1A8FBD',
  sand: '#F6DFA8',
  sandEdge: '#E8C67C',

  coin: '#FFC83D',
  danger: '#D43C4E',
  toast: '#2E2A28',
} as const;

export const fonts = {
  display: 'Huninn',
  number: 'Baloo2',
} as const;

export const radius = {
  card: 18,
  button: 14,
} as const;

export const type = {
  title: { fontFamily: fonts.display, fontSize: 24, color: colors.ink },
  label: { fontSize: 12, color: colors.muted, letterSpacing: 0.6 },
  body: { fontSize: 15, color: colors.ink, lineHeight: 22 },
  small: { fontSize: 12, color: colors.muted },
} as const;
