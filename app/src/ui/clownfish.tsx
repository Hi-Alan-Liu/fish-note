import { Canvas, Circle, Group, Oval, Path, RadialGradient, vec } from '@shopify/react-native-skia';

/**
 * Port of the clownfish "橘橘" from prototypes/clownfish/index.html. The SVG paths are
 * reused verbatim in the prototype's viewBox (-82 -62 164 124) and scaled to the canvas.
 */

export type FishMouth = 'smile' | 'open' | 'o';

export interface FishPose {
  /** Degrees. */
  tailAngle?: number;
  pecAngle?: number;
  dorsalAngle?: number;
  /** 1 = open, ~0.1 = blink. */
  eyeScaleY?: number;
  /** Wide eyes with small pupils. */
  fear?: boolean;
  mouth?: FishMouth;
  /** 0–1 opacity of the sweat drop. */
  sweat?: number;
}

export const CLOWNFISH_ASPECT = 124 / 164;

const OUTLINE = '#2B1D1A';
const DEG = Math.PI / 180;

const BODY = 'M54 0 C54 -31 26 -45 -4 -43 C-34 -41 -50 -21 -50 0 C-50 21 -34 41 -4 43 C26 45 54 31 54 0 Z';
const TAIL = 'M-44 0 C-58 -8 -66 -27 -77 -30 C-83 -15 -81 -6 -72 0 C-81 6 -83 15 -77 30 C-66 27 -58 8 -44 0 Z';
const TAIL_STRIPE = 'M-70 -24 C-76 -14 -76 -6 -70 0 C-76 6 -76 14 -70 24';
const DORSAL = 'M-26 -36 C-22 -58 6 -62 16 -40 Z';
const PELVIC = 'M-8 38 C-4 54 12 56 16 37 Z';
const STRIPES = [
  'M8 -50 Q17 0 8 50 L23 50 Q31 0 23 -50 Z',
  'M-24 -50 Q-15 0 -24 50 L-10 50 Q-2 0 -10 -50 Z',
  'M-52 -50 Q-45 0 -52 50 L-42 50 Q-36 0 -42 -50 Z',
];
const PEC = 'M4 12 C-10 14 -18 25 -12 31 C-3 30 6 22 4 12 Z';
const SMILE = 'M45 6 Q49.5 10.5 53 5.5';
const SWEAT = 'M-14 -48 C-10 -42 -8 -38 -11 -35 C-14 -32 -19 -35 -18 -39 C-17.5 -42 -15 -45 -14 -48 Z';

function Orange() {
  return <RadialGradient c={vec(-14, -18)} r={80} colors={['#FFB066', '#FF7A2E', '#F05A14']} positions={[0, 0.55, 1]} />;
}

function Outlined({ d, width, fill }: { d: string; width: number; fill?: string }) {
  return (
    <>
      <Path path={d} color={fill}>
        {fill ? null : <Orange />}
      </Path>
      <Path path={d} style="stroke" strokeWidth={width} color={OUTLINE} strokeJoin="round" strokeCap="round" />
    </>
  );
}

/** Draws the fish facing right inside an already-scaled viewBox group. */
export function ClownfishArt({ pose = {} }: { pose?: FishPose }) {
  const { tailAngle = 0, pecAngle = 0, dorsalAngle = 0, eyeScaleY = 1, fear = false, mouth = 'smile', sweat = 0 } = pose;
  const eyeScale = fear ? 1.15 : 1;

  return (
    <Group>
      <Group origin={vec(-44, 0)} transform={[{ rotate: tailAngle * DEG }]}>
        <Outlined d={TAIL} width={2.4} />
        <Path path={TAIL_STRIPE} style="stroke" strokeWidth={3.5} color="#FFFFFF" strokeCap="round" />
      </Group>

      <Group origin={vec(-5, -38)} transform={[{ rotate: dorsalAngle * DEG }]}>
        <Outlined d={DORSAL} width={2.4} />
      </Group>
      <Outlined d={PELVIC} width={2.4} />

      <Path path={BODY}>
        <Orange />
      </Path>
      <Group clip={BODY}>
        {STRIPES.map((d) => (
          <Outlined key={d} d={d} width={2.6} fill="#FFFFFF" />
        ))}
        <Oval x={-16} y={-35} width={60} height={18} color="rgba(255,255,255,0.28)" />
      </Group>
      <Path path={BODY} style="stroke" strokeWidth={2.6} color={OUTLINE} />

      <Oval x={29.5} y={8.2} width={13} height={7.6} color="rgba(255,95,138,0.55)" />

      <Group transform={[{ translateX: 32 }, { translateY: -9 }, { scaleX: eyeScale }, { scaleY: fear ? 1.15 : eyeScaleY }]}>
        <Circle cx={0} cy={0} r={13} color="#FFFFFF" />
        <Circle cx={0} cy={0} r={13} style="stroke" strokeWidth={2.4} color={OUTLINE} />
        <Circle cx={fear ? 1 : 2.5} cy={0.5} r={fear ? 4.2 : 8.5} color={OUTLINE} />
        <Circle cx={5.5} cy={-3.5} r={3} color="#FFFFFF" />
        <Circle cx={-0.5} cy={4} r={1.4} color="#FFFFFF" />
      </Group>

      {mouth === 'smile' && (
        <Path path={SMILE} style="stroke" strokeWidth={2.4} color={OUTLINE} strokeCap="round" />
      )}
      {mouth === 'open' && (
        <>
          <Oval x={46} y={1} width={8} height={10} color={OUTLINE} />
          <Oval x={47.5} y={6.5} width={5} height={4} color="#FF7F9E" />
        </>
      )}
      {mouth === 'o' && <Oval x={47.9} y={2.8} width={5.2} height={6.4} color={OUTLINE} />}

      <Group origin={vec(4, 12)} transform={[{ rotate: pecAngle * DEG }]}>
        <Outlined d={PEC} width={2.2} fill="#FF9A52" />
      </Group>

      {sweat > 0 && (
        <Group opacity={Math.min(1, sweat)}>
          <Path path={SWEAT} color="#BFEAFF" />
          <Path path={SWEAT} style="stroke" strokeWidth={1.6} color="#3A87B5" />
        </Group>
      )}
    </Group>
  );
}

/** Stand-alone fish picture, `width` wide. */
export function Clownfish({ width, pose }: { width: number; pose?: FishPose }) {
  const k = width / 164;
  return (
    <Canvas style={{ width, height: width * CLOWNFISH_ASPECT }}>
      <Group transform={[{ scale: k }, { translateX: 82 }, { translateY: 62 }]}>
        <ClownfishArt pose={pose} />
      </Group>
    </Canvas>
  );
}
