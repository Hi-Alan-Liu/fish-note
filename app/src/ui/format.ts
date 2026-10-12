const thousands = new Intl.NumberFormat('en-US', { maximumFractionDigits: 0 });

export const formatAmount = (n: number) => thousands.format(n);

export const formatMoney = (n: number, symbol = 'NT$') => `${symbol} ${formatAmount(n)}`;

export const formatSigned = (n: number) => (n > 0 ? `+${formatAmount(n)}` : n < 0 ? `-${formatAmount(-n)}` : '0');

const WEEKDAYS = ['日', '一', '二', '三', '四', '五', '六'];

/** 10/12（日） */
export function formatDayHeader(ms: number): string {
  const d = new Date(ms);
  return `${d.getMonth() + 1}/${d.getDate()}（${WEEKDAYS[d.getDay()]}）`;
}

export function isSameDay(a: number, b: number): boolean {
  const x = new Date(a);
  const y = new Date(b);
  return x.getFullYear() === y.getFullYear() && x.getMonth() === y.getMonth() && x.getDate() === y.getDate();
}
