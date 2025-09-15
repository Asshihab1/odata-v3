import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class QueryBuilder implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const query: any = {};
    const paramsParts = req.path.split('/').filter(Boolean);

    if (paramsParts.length >= 3) {
      let entityPart = paramsParts[2];
      let entity = entityPart;
      let id: string | undefined = undefined;

      if (req.query) {
        console.log(req.query, 'orginal query');
        const { $select, $filter, $top, $skip, $orderby, $expand } = req.query;

        if ($select) query.select = this.parseSelect($select as string);
        if ($filter) query.where = this.parseFilter($filter as string);
        if ($top) query.take = Number($top);
        if ($skip) query.skip = Number($skip);
        if ($orderby) query.orderBy = this.parseOrderBy($orderby as string);
        if ($expand) query.include = this.parseExpand($expand as string);
      }

      //  prefix and id
      const match = entityPart.match(/^(\w+)\((\d+)\)$/);
      if (match) {
        entity = match[1];
        id = match[2];
      } else if (paramsParts[3]) {
        id = paramsParts[3];
      }

      if (id) {
        query.where = query.where
          ? { AND: [{ id: BigInt(id) }, query.where] }
          : { id: BigInt(id) };
      }
      req['entity'] = entity;
      req['id'] = id;
      req['prismaQuery'] = query;
      console.log(query, 'prismaQuery', entity, id);
    }

    next();
  }

  private parseSelect(selectStr: string) {
    const fields = selectStr.split(',').map((filed: any) => filed.trim());
    const select: any = {};
    fields.forEach((selectTable: any) => (select[selectTable] = true));
    return select;
  }

  private parseOrderBy(orderByStr: string) {
    const [field, direction] = orderByStr.split(' ');
    return { [field]: direction?.toLowerCase() === 'desc' ? 'desc' : 'asc' };
  }

  private parseFilter(filterStr: string): any {
    const logicalOperator = filterStr.includes(' or ') ? 'OR' : 'AND';
    const conditions =
      logicalOperator === 'AND'
        ? filterStr.split(' and ')
        : filterStr.split(' or ');

    const prismaConditions = conditions
      .map((cond) => {
        const match = cond.match(/^(\w+)\s+(eq|ne|gt|ge|lt|le)\s+(.+)$/);
        if (!match) return null;
        const [, field, op, rawValue] = match;

        let value: any = rawValue.trim().replace(/^'(.+)'$/, '$1');
        if (!isNaN(Number(value))) value = Number(value);
        else if (value.toLowerCase() === 'true') value = true;
        else if (value.toLowerCase() === 'false') value = false;

        const prismaOp =
          op === 'eq'
            ? typeof value === 'string'
              ? 'contains'
              : 'equals'
            : op === 'ne'
              ? 'not'
              : op === 'gt'
                ? 'gt'
                : op === 'ge'
                  ? 'gte'
                  : op === 'lt'
                    ? 'lt'
                    : 'lte';

        return prismaOp === 'contains' && typeof value === 'string'
          ? { [field]: { contains: value } }
          : { [field]: { [prismaOp]: value } };
      })
      .filter(Boolean);

    return prismaConditions.length === 1
      ? prismaConditions[0]
      : { [logicalOperator]: prismaConditions };
  }

  //  $expand
  private parseExpand(expandStr: string): any {
    const include: any = {};

    const splitTopLevel = (str: string) => {
      const parts: string[] = [];
      let depth = 0,
        current = '';
      for (const char of str) {
        if (char === '(') depth++;
        if (char === ')') depth--;
        if (char === ',' && depth === 0) {
          parts.push(current);
          current = '';
        } else current += char;
      }
      if (current) parts.push(current);
      return parts.map((p) => p.trim());
    };

    const parsePart = (str: string): any => {
      const m = str.match(/^(\w+)(\((.+)\))?$/);
      if (!m) return;
      const [_, relation, __, inner] = m;
      return inner
        ? {
            [relation]: {
              include: Object.assign(
                {},
                ...splitTopLevel(inner).map(parsePart),
              ),
            },
          }
        : { [relation]: true };
    };

    Object.assign(include, ...splitTopLevel(expandStr).map(parsePart));
    console.log(include, 'include');
    return include;
  }
}
