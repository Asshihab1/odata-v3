
export function serializeBigInt(obj: any): any {
  if (Array.isArray(obj)) return obj.map(serializeBigInt);

  if (obj && typeof obj === 'object') {
    const res: any = {};
    for (const key in obj) {
      if (!Object.prototype.hasOwnProperty.call(obj, key)) continue;
      const value = obj[key];
      res[key] = typeof value === 'bigint' ? value.toString() : serializeBigInt(value);
    }
    return res;
  }

  return obj;
}