// Skia needs a native canvas; component tests only check behaviour, so draw nothing.
jest.mock('@/ui/clownfish', () => ({
  CLOWNFISH_ASPECT: 124 / 164,
  Clownfish: () => null,
  ClownfishArt: () => null,
}));

// Vector icons load their font asynchronously, which only adds act() noise in tests.
jest.mock('@expo/vector-icons', () => {
  const Ionicons = () => null;
  Ionicons.glyphMap = {};
  return { Ionicons };
});
